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
  const MostVisited({Key? key}) : super(key: key);

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
     double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    // if (isLoading) {
    //   return Center(child: CircularProgressIndicator());
    // }
    // if (categoriesList.isEmpty) {
    //   return Center(child: Text("No categories available"));
    // }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 6, bottom: 30),
      height: height*0.36,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.6,
          crossAxisCount: 1,
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
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 2),
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
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
          width: width*0.4,
          height: height*0.31,
          margin: EdgeInsets.only(right: 2,left: 2,top: 2), // Reduced margin
          decoration: BoxDecoration(
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.3),
            //     spreadRadius: 1,
            //     blurRadius: 1,
            //     offset: Offset(2, 2),
            //   ),
            // ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                       

                       
                      
                        
                        height: 160,
                        width: 160,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                              imageUrl: category.image[0],
                              height: 160,
                              width: 160,
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
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        
                        //  ClipRRect(
                        //   borderRadius: BorderRadius.circular(8),
                        //   child: Image.network(
                        //     category.image[0],
                        //     fit: BoxFit.cover,
                        //   ),
                        // ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            //  Text(calculateTimeDifference(category.date), style: TextStyle(fontSize: 14)),
      
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text("Rs. ${category.rent}",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(category.address,
                                  style: TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 16, color: Colors.black)),
                            ),
      
                            SizedBox(
                              height: 5,
                            ),
                            //Text("Rs ${category.price}", style: TextStyle(fontSize: 14)),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 6, right: 6, top: 6, bottom: 6),
                              decoration: BoxDecoration(
                                  color: category.isFavourite
                                      ? Colors.green
                                      : Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Text(
                                "Post On :- ${calculateTimeDifference(category.date)}",
                                style: TextStyle(
                                  fontSize: 14,
                                  //fontWeight: FontWeight.bold,
                                  color: category.isFavourite
                                      ? Colors.white
                                      : Colors.white,
                                ),
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
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(  
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    color: Colors.grey.shade300
                  ),
                  child: Icon(
                    category.isFavourite ? Icons.lock_open : Icons.lock_outline,
                    color: category.isFavourite ? Colors.green : Colors.red,
                    size: 25,
                  ),
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
