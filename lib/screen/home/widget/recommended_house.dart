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
  final bool toprent;
  RecommendedHouse({
    Key? key,
    required this.toprent,
  }) : super(key: key);

  @override
  State<RecommendedHouse> createState() => _RecommendedHouseState();
}
class _RecommendedHouseState extends State<RecommendedHouse> {
  List<CategoryModel> categoriesList = [];
  bool isLoading = false;
  List<int> plusList = [];
  ScrollController _scrollController = ScrollController();
  int _itemsToLoad = 5; // Load 5 items initially

  @override
  void initState() {
    super.initState();
    getCategoryList();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      // If the user has scrolled to the end, load more items
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
        // Only load more items if there are more items in the categoriesList to display
        if (_itemsToLoad < categoriesList.length) {
          _itemsToLoad += 5; // Increase the number of items to load
        }
      });
      // Simulate a network call delay for loading more items
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  void getCategoryList() async {
    if (categoriesList.isNotEmpty) {
      return;
    }

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

    // Show shimmer effect while loading
    if (isLoading) {
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

    return categoriesList.isEmpty
        ? Center(child: Text("No categories available"))
        : Container(
            padding: EdgeInsets.only(left: 0, top: 0, bottom: 2),
            height: height * 0.45,
            color: Colors.white,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: _itemsToLoad, // Load more items as user scrolls
              itemBuilder: (context, index) {
                if (index >= categoriesList.length) {
                  return Container(); // Return an empty container if index exceeds available items
                }

                CategoryModel category = categoriesList[index];
                return CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () async {
                    setState(() {
                      plusList[index]++;
                    });

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setInt("num_${category.id}", plusList[index]);

                    await updateViewCount(category.viewId);

                    Navigator.push(
                      context,
                      PageTransition(
                        child: DetailPage(
                          categoryModel: categoriesList[index],
                          plus: plusList[index],
                        ),
                        type: PageTransitionType.fade,
                        duration: Duration(milliseconds: 400),
                      ),
                    );
                  },
                  child: Container(
                    height: height * 0.6,
                    width: width * 0.56,
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                    margin: EdgeInsets.only(
                        left: 10, right: 10, top: 2, bottom: 2),
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
                        CachedNetworkImage(
                          imageUrl: category.image[0],
                          height: 390,
                          width: 230,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, error, stackTrace) => Center(child: Icon(Icons.error)),
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
                                ? Icon(Icons.lock_open_rounded,
                                    size: 25, color: Colors.green)
                                : Icon(Icons.lock_outline,
                                    color: Colors.red, size: 25),
                          ),
                        ),
                        Positioned(
                          left: 10,
                          top: 15,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            decoration: BoxDecoration(
                                color: category.isFavourite
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              "${calculateTimeDifference(category.date)}",
                              style: TextStyle(
                                fontSize: 14,
                                color: category.isFavourite
                                    ? Colors.white
                                    : Colors.white,
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
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Rs. ${category.rent}",
                                          style: TextStyle(color: Colors.white)),
                                      Text(
                                        category.address.isNotEmpty
                                            ? category.address[0].toUpperCase() +
                                                category.address.substring(1)
                                            : "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.favorite_outline,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
