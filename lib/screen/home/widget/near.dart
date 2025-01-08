import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:intl/intl.dart';

class Near extends StatefulWidget {
  String? address;
  
   Near({Key? key, this.address }) : super(key: key);

  @override
  State<Near> createState() => _NearState();
}

class _NearState extends State<Near> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productByCategoryList=[];
List<ProductModel> productByCategoryList2=[];
  bool isLoading = false;
  String name="the";

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
  void initState(){
    super.initState();
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

    categoriesList = await FirebaseFirestoreHelper.instance.getNear(widget.address!=null?widget.address!:_currentAddress);

    setState(() {
      isLoading = false;
    });
  }

  String calculateTimeDifference(String dateString) {
    DateTime postDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(postDate);
    int differenceInDays=difference.inDays;

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    }
   else if (differenceInDays == 0) {
    return 'Today';
  } else if (differenceInDays == 1) {
    return '1 day ago';
  } 
    
     else {
          return '$differenceInDays days ago';

      //return DateFormat('yyyy-MM-dd').format(postDate);
    }




  }

  //   filterByBrand(List<String> brands) {
  //   if (brands.isEmpty) {
  //     productByCategoryList2 = productByCategoryList;
  //   } else {
  //     List<String> lowereCaseBrands =
  //         brands.map((brand) => brand.toLowerCase()).toList();
  //     productByCategoryList2 = productByCategoryList
  //         .where((product) =>
  //             lowereCaseBrands.contains(product.name?.toLowerCase()))
  //         .toList();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (categoriesList.isEmpty) {
      return Center(child: Text("No categories available${_currentAddress}"));
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 306,
      
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      childAspectRatio: 0.46,
          crossAxisCount: 2,
         // childAspectRatio: 1.5, // Adjust aspect ratio for better spacing
        ),
        itemCount: categoriesList.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: categoriesList[index]);
        },
      ),
    );
  }
}



class CategoryCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth=MediaQuery.of(context).size.width;
    double cardWidth=(screenWidth);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
          context,
          PageTransition(
            child: DetailPage(categoryModel: category),
            type: PageTransitionType.fade,
            duration: Duration(milliseconds: 400),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: 160,
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
                      height: 133,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          category.image[0],
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
                          Text(category.name, style: TextStyle(fontSize: 14)),
                          Text(category.address, style: TextStyle(fontSize: 14)),
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
                category.isFavourite ? Icons.lock_open : Icons.lock_outline,
                color: category.isFavourite ? Colors.green : Colors.red,
                size: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

