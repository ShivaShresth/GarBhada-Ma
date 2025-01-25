import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Recents extends StatefulWidget {
  const Recents({Key? key}) : super(key: key);

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  List<CategoryModel> categoriesList = [];
  bool isLoading = false;
  List<int> plusList = [];

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    categoriesList = await FirebaseFirestoreHelper.instance.getCat();
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
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (categoriesList.isEmpty) {
      return Center(child: Text("No categories available"));
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 6,top: 4),
     // padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5), // Reduced margin
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
                      height: 140,
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

