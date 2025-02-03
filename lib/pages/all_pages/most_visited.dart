import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:intl/intl.dart';
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
                        imageUrl: category.image[0],
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
                            "Rs. ${category.rent}",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(
                            category.address.isNotEmpty
                                ? category.address[0].toUpperCase() +
                                    category.address.substring(1)
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
                            color: category.isFavourite
                                ? Colors.green
                                : Colors.red,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            "Post On: ${calculateTimeDifference(category.date)}",
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
                            child: category.isFavourite
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
