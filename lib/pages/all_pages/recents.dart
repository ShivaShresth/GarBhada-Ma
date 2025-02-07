// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/detail.dart';

class Recents extends StatefulWidget {
  bool? recents;
   Recents({
    Key? key,
     this.recents=false,
  }) : super(key: key);

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

     // Shuffle categoriesList only when widget.recents is false
    if (widget.recents == null || widget.recents == false) {
      categoriesList.shuffle();
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 6, top: 0,bottom: 6),
      height: height /2.6,
      child:( isLoading|| widget.recents!)
          ? _buildShimmerEffect()
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.46,
                crossAxisCount: 2,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: categoriesList[index], index: index,onUpdateViewCount: updateViewCount,);
              },
            ),
    );
  }

  // Build shimmer effect when loading
  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.46,
          crossAxisCount: 2,
        ),
        itemCount: 5, // Show 5 shimmer items (adjust as needed)
        itemBuilder: (context, index) {
          return CategoryCardShimmer();
        },
      ),
    );
  }
}


// A separate widget for the shimmer effect of the category card
class CategoryCardShimmer extends StatelessWidget {
  const CategoryCardShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      width: screenWidth,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.white,
                child: Container(
                  height: 140,
                  width: 120,
                  color: Colors.grey.shade300,
                ),
              ),
              SizedBox(width: 16),
              Column(
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 120,
                      height: 20,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: 6),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 150,
                      height: 20,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  SizedBox(height: 16),
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      width: 100,
                      height: 20,
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double cardWidth = (screenWidth);
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
        height: height*0.2,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
                      height: height*0.17,
                      width: cardWidth*0.26,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CachedNetworkImage(
                            imageUrl: widget.category.image[0],
                            height: height*0.2,
                            width: cardWidth*0.1,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey.shade300, // Darker base color
              highlightColor: Colors.white,    // Lighter highlight color
              child: Container(
               
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
            
                            
                            
                            ),
                            errorWidget: (context, error, stackTrace) => Center(child: Icon(Icons.error)),
                          ),
                      ),


                      
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(8),
                      //   child: Image.network(
                      //     category.image[0],
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                    ),
                    SizedBox(width: cardWidth*0.06),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: height*0.05),
                          Text(
                            "Rs. ${widget.category.rent}",
                            style: TextStyle(fontSize: cardWidth*0.04, color: Colors.black),
                          ),
                          SizedBox(height: height*0.002),
                          Container(
                            width: 190,
                            child: Text(
                              widget.category.address.isNotEmpty
                                  ? widget.category.address[0].toUpperCase() + widget.category.address.substring(1)
                                  : "",  // In case the address is empty, it avoids showing null or empty text
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.black,
                                overflow:TextOverflow.ellipsis
                              ),
                            ),
                          ),

                          // Text(
                          //   category.address,
                          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                          // ),
                          SizedBox(height: height*0.01),
                          Container(
                            padding: EdgeInsets.only(left: cardWidth*0.02, right: cardWidth*0.02, top: height*0.006, bottom: height*0.006),
                            decoration: BoxDecoration(
                              color: widget.category.isFavourite ? Colors.green : Colors.red,
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            
                            
                            child: Text(
                              "Post On :- ${calculateTimeDifference(widget.category.date)}",
                              style: TextStyle(fontSize: cardWidth*0.03, color: Colors.white),
                            ),
                          ),
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
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                child: Icon(
                  widget.category.isFavourite ? Icons.lock_open : Icons.lock_outline,
                  color: widget.category.isFavourite ? Colors.green : Colors.red,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
}
