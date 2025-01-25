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

class RecommendedHouse extends StatefulWidget {
  const RecommendedHouse({Key? key}) : super(key: key);

  @override
  State<RecommendedHouse> createState() => _RecommendedHouseState();
}

class _RecommendedHouseState extends State<RecommendedHouse> {
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
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : categoriesList.isEmpty
            ? Center(child: InkWell(
              onTap: (){  
                print(categoriesList);
              },
              child: Text("No categories available${categoriesList}")))
            : Container(
                padding: EdgeInsets.only(left: 0,top: 6,bottom: 2),
                height: 400,
                color: Colors.white,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    CategoryModel category = categoriesList[index];
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        setState(() {
                          plusList[index]++;
                        });

                        SharedPreferences prefs = await SharedPreferences.getInstance();
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
                        height: 390,
                        width: 230,
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
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              child: Image.network(
                                category.image[0],
                                height: 390,
                                width: 230,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(child: CircularProgressIndicator());
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Center(child: Icon(Icons.error));
                                },
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 15,
                              child: category.isFavourite
                                  ? Icon(Icons.lock_open_rounded, size: 25, color: Colors.green)
                                  : Icon(Icons.lock_outline, color: Colors.red, size: 25),
                            ),
                            Positioned(
                              left: 10,
                              top: 15,
                              child: Text(
                                "Posted ${calculateTimeDifference(category.date)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: category.isFavourite ? Colors.black : Colors.red,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: Container(
                                color: Colors.white54,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(category.name),
                                          Text(category.address),
                                        ],
                                      ),
                                    ),
                                    Icon(Icons.favorite_outline, size: 20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => SizedBox(width: 0),
                  itemCount: categoriesList.length,
                ),
              );
  }
}
