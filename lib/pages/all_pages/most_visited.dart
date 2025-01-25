

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:intl/intl.dart';

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
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (categoriesList.isEmpty) {
      return Center(child: Text("No categories available"));
    }

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(left: 6,bottom: 30),
      height: 306,
      
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
        width: 160,
        height: 360,
        margin: EdgeInsets.only(right: 14), // Reduced margin
        decoration: BoxDecoration(
          
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 0,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 160,
                      width: 160,
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
                      padding: EdgeInsets.only(left: 10),
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
