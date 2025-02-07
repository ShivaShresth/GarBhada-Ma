import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class MostVisited extends StatefulWidget {
  bool? mostvisited;
  MostVisited({Key? key, this.mostvisited}) : super(key: key);

  @override
  State<MostVisited> createState() => _MostVisitedState();
}

class _MostVisitedState extends State<MostVisited> {
  List<CategoryModel> categoriesList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getCategoryList();
  }

  Future<void> getCategoryList() async {
    setState(() {
      isLoading = true;
    });

    try {
      categoriesList = await FirebaseFirestoreHelper.instance.getCat();
    } catch (e) {
      print("Error fetching categories: $e");
    }

    setState(() {
      isLoading = false;
    });
  }

  String calculateTimeDifference(String dateString) {
    DateTime postDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
    Duration difference = DateTime.now().difference(postDate);
    int differenceInDays = difference.inDays;

    if (difference.inSeconds < 60) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} minutes ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    if (differenceInDays == 1) return '1 day ago';
    return '$differenceInDays days ago';
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
    if (widget.mostvisited == null || widget.mostvisited == false) {
      categoriesList.shuffle();
    }


    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 6, bottom: 10,top: 10),
      height: height * 0.4,
      child: isLoading || widget.mostvisited == true
          ? GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.6,
                crossAxisCount: 1,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300, // Darker base color
                  highlightColor: Colors.white, // Lighter highlight color
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
                );
              },
            )
          : GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1.6,
                crossAxisCount: 1,
              ),
              itemCount: categoriesList.length,
              itemBuilder: (context, index) {
                return CategoryCard(category: categoriesList[index],index: index,onUpdateViewCount:updateViewCount,);
              },
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: 4,right: 6,bottom: 6,top: 6),
      //padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: CupertinoButton(
        color: Colors.white,
        padding: EdgeInsets.zero,
        onPressed: () async{
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
          width: width * 0.46,
          height: height * 0.355,
          decoration: BoxDecoration(
          
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 3,
            blurRadius: 2,
            offset: Offset(2, 2),
          ),
        ],
      
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Container(
                    
                    margin: EdgeInsets.only(top: 6,left: 4,right: 3),
                    height: height * 0.2,
                    width: width * 0.45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: widget.category.image[0],
                        height: height * 0.2,
                        width: width * 0.4,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.white,
                          child: Container(
                            height: height * 0.2,
                            width: width * 0.4,
                            color: Colors.grey.shade300,
                          ),
                        ),
                        errorWidget: (context, error, stackTrace) =>
                            Center(child: Icon(Icons.error)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.02),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            "Rs. ${widget.category.rent}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            widget.category.address.isNotEmpty
                                ? widget.category.address[0].toUpperCase() +
                                    widget.category.address.substring(1)
                                : "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 6, horizontal: 6),
                          decoration: BoxDecoration(
                            color: widget.category.isFavourite
                                ? Colors.green
                                : Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "Post On: ${calculateTimeDifference(widget.category.date)}",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 10,
                right: 10,
                child:  Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                shape: BoxShape.circle),
                            child: widget.category.isFavourite
                                ? Icon(Icons.lock_open_rounded,
                                    size: 25, color: Colors.green)
                                : Icon(Icons.lock_outline,
                                    color: Colors.red, size: 25),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String calculateTimeDifference(String dateString) {
    DateTime postDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
    Duration difference = DateTime.now().difference(postDate);
    int differenceInDays = difference.inDays;

    if (difference.inSeconds < 60) return 'Just now';
    if (difference.inMinutes < 60) return '${difference.inMinutes} minutes ago';
    if (difference.inHours < 24) return '${difference.inHours} hours ago';
    if (differenceInDays == 1) return '1 day ago';
    return '$differenceInDays days ago';
  }
}
