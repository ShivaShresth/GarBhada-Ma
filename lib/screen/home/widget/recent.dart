import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recent extends StatefulWidget {
  const Recent({Key? key}) : super(key: key);

  @override
  State<Recent> createState() => _RecentState();
}

class _RecentState extends State<Recent> {
  List<CategoryModel> categoriesList = [];
  bool isLoading = false;
  List<int> plusList = [];


     Position? _currentLocation;
    late bool servicePermission = false;
    late LocationPermission permission;
     String? address1;
    String _currentAddress = "";
    Future<Position> _getCurrentLocation() async {
      servicePermission = await Geolocator.isLocationServiceEnabled();
      if (!servicePermission) {
        print("Service disabled");
      }
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      return await Geolocator.getCurrentPosition();
    }


    _getAddressFromCoordinates()async{  
      try{  
        List<Placemark> placesmarks=await placemarkFromCoordinates(_currentLocation!.latitude, _currentLocation!.longitude);
        Placemark place=placesmarks[0];
          Placemark placemark = placesmarks.first;
      String address = "${placemark.name}, ${placemark.locality}, ${placemark.country}";
      

        setState(() {
          _currentAddress="${place.locality}";
address1=address;
        });
      }catch(e){ 
        print(e);
      }
    }


  @override
  void initState() {
    super.initState();
    getCategoryList();
          _initialize();

  }

Future<void> _initialize() async {
 _currentLocation= await _getCurrentLocation();
  await _getAddressFromCoordinates();
  getCategoryList();
}


  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoriesList = await FirebaseFirestoreHelper.instance.getDate(_currentAddress.toLowerCase());
    plusList = List.generate(categoriesList.length, (_) => 0);

    setState(() {
      isLoading = false;
    });
  }

  String calculateTimeDifference(String dateString) {
    DateTime postDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(postDate);
    int differenceInDays = difference.inDays;

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (differenceInDays == 0) {
      return 'Today';
    } else if (differenceInDays == 1) {
      return '1 day ago';
    } else {
      return '$differenceInDays days ago';
    }
  }

  Future<void> updateViewCount(String? viewId) async {
    if (viewId == null) {
      print("viewId is null");
      return;
    }

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print("User is not authenticated");
        return;
      }

      DocumentReference doc = FirebaseFirestore.instance
          .collection("cat")
          .doc(user.uid)
          .collection("cats")
          .doc(viewId);

      // Fetch current view count
      DocumentSnapshot snapshot = await doc.get();

      // Cast the data to Map<String, dynamic>
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      // Get the current view count or default to 0
      int currentViewCount = data?['view'] ?? 0;

      // Update the view count
      await doc.set({"view": currentViewCount + 1}, SetOptions(merge: true));
      print("Updated view count for $viewId to ${currentViewCount + 1}");
    } catch (e) {
      print("Error updating view count: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update view count")),
      );
    }
  }

   @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    // if (isLoading) {
    //   return Center(child: CircularProgressIndicator());
    // }
    if (categoriesList.isEmpty) {
      return Center(child: Text("${_currentAddress} No categories available"));
    }

    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: height*0.60,
          
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.46,
              crossAxisCount: 3,
             // childAspectRatio: 1.5, // Adjust aspect ratio for better spacing
            ),
            itemCount: categoriesList.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: categoriesList[index],index: index,onUpdateViewCount: updateViewCount);
            },
          ),
        ),
     
      ],
    );
  }
 
}




class CategoryCard extends StatefulWidget {
  final CategoryModel category;
    final int index;
  final Function? onUpdateViewCount;

   CategoryCard({Key? key, required this.category, required this.index, this.onUpdateViewCount}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
     double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    double screenWidth=MediaQuery.of(context).size.width;
    double cardWidth=(screenWidth);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: ()async{
           // Increment view count
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int currentViewCount = prefs.getInt("num_${widget.category.id}") ?? 0;
        prefs.setInt("num_${widget.category.id}", currentViewCount + 1);

        // Update the view count in Firestore
        if (widget.onUpdateViewCount != null) {
          await widget.onUpdateViewCount!( widget.category.viewId);
        }
        Navigator.push(
          context,
          PageTransition(
            child: DetailPage(categoryModel: widget.category),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 400),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: height*0.6,
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5), // Reduced margin
        decoration: BoxDecoration(
          
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(2, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: height*0.178,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.category.image[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30,),
                        //  Text(calculateTimeDifference(category.date), style: TextStyle(fontSize: 14)),
                          Text(widget.category.name, style: TextStyle(fontSize: 14)),
                          Text(widget.category.address, style: TextStyle(fontSize: 14)),
                          //Text("Rs ${category.price}", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Icon(
                widget.category.isFavourite ? Icons.lock_open : Icons.lock_outline,
                color: widget.category.isFavourite ? Colors.green : Colors.red,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

