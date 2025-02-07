import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/detail.dart';

class RecommendedHouse extends StatefulWidget {
  final bool? toprent;
  RecommendedHouse({
    Key? key,
    this.toprent,
  }) : super(key: key);

  @override
  State<RecommendedHouse> createState() => _RecommendedHouseState();
}

class _RecommendedHouseState extends State<RecommendedHouse> {
  List<CategoryModel> categoriesList = [];
  bool isLoading = false;
  List<int> plusList = [];
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

   void getCategoryList() async {
    if (categoriesList.isNotEmpty) return;

    setState(() {
      isLoading = true;
    });

    categoriesList = await FirebaseFirestoreHelper.instance.getCat();

    // // Shuffle only if the toprent flag is false, and shuffle only once during initialization.
    // if (widget.toprent == null || widget.toprent == false) {
    //   categoriesList.shuffle();
    // }

    plusList = List.generate(categoriesList.length, (_) => 0); // Only generate plusList once
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

      DocumentSnapshot snapshot = await doc.get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      int currentViewCount = data?['view'] ?? 0;

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
 if (widget.toprent == null || widget.toprent == false) {
      categoriesList.shuffle();
    }

    // Show shimmer effect while loading
    if (isLoading|| widget.toprent==true) {
      return Container(
        padding: EdgeInsets.only(left: 0, top: 0, bottom: 2),
        height: height * 0.45,
        color: Colors.white,
        child: ListView.separated(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300, // Darker base color
              highlightColor: Colors.white,    // Lighter highlight color
              child: Container(
                height: height * 0.6,
                width: width * 0.56,
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                margin: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      spreadRadius: 3,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
          },
          separatorBuilder: (_, index) => SizedBox(width: 0),
          itemCount: 5, // Display 5 shimmer placeholders
        ),
      );
    }

   
      
    // }

    return categoriesList.isEmpty
        ? Center(child: Text("No categories available"))
        : _buildCategoryList(height, width);
  }

  Widget _buildShimmerEffect(double height, double width) {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, bottom: 2),
      height: height * 0.45,
      color: Colors.white,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            child: Container(
              height: height * 0.6,
              width: width * 0.56,
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              margin: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    spreadRadius: 3,
                    blurRadius: 3,
                    offset: Offset(2, 2),
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        },
        separatorBuilder: (_, index) => SizedBox(width: 0),
        itemCount: categoriesList.length,
      ),
    );
  }

  Widget _buildCategoryList(double height, double width) {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, bottom: 2),
      height: height * 0.45,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length, // Ensure the item count matches the data list
        itemBuilder: (context, index) {
          // Ensure we're not accessing an out-of-bounds index
          if (index >= categoriesList.length) {
            print("Index out of bounds: $index");
            return Container();
          }

          CategoryModel category = categoriesList[index];

          return CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () async {


              // Only update the specific index's state and don't modify the entire list
              // setState(() {
              //   plusList[index]++; // Increment the view count only for the pressed item
              // });

              SharedPreferences prefs = await SharedPreferences.getInstance();
              // Safely store values for each category index
              await prefs.setInt("num_${category.id}", plusList[index]);

              // Ensure the view ID is not null before updating the view count
              await updateViewCount(category.viewId);

              Navigator.push(
                context,
                PageTransition(
                  child: DetailPage(
                    categoryModel: category,
                    plus: plusList[index],
                  ),
                  type: PageTransitionType.fade,
                  duration: Duration(milliseconds: 400),
                ),
              );
            },
            child: _buildCategoryItem(height, width, category, index),
          );
        },
      ),
    );
  }

  Widget _buildCategoryItem(double height, double width, CategoryModel category, int index) {
    return Container(
      height: height * 0.6,
      width: width * 0.56,
      padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
      margin: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
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
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: CachedNetworkImage(
              imageUrl: category.image[0],
              height: 390,
              width: 230,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, error, stackTrace) => Center(child: Icon(Icons.error)),
            ),
          ),
          Positioned(
            right: 8,
            top: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle),
              child: category.isFavourite
                  ? Icon(Icons.lock_open_rounded, size: 25, color: Colors.green)
                  : Icon(Icons.lock_outline, color: Colors.red, size: 25),
            ),
          ),
          Positioned(
            left: 10,
            top: 15,
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
              decoration: BoxDecoration(
                  color: category.isFavourite ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Text(
                "${calculateTimeDifference(category.date)}",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.2),
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Rs. ${category.rent}", style: TextStyle(color: Colors.white)),
                        Text(
                          category.address.isNotEmpty
                              ? category.address[0].toUpperCase() + category.address.substring(1)
                              : "",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.favorite_outline, size: 20, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
