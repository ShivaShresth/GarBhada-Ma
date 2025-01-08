// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/all_pages/most_visited.dart';
import 'package:renthouse/screen/detail/detail.dart';

class Filter_Page_Display extends StatefulWidget {
  String property;
  String priceg;
  String pricel;
  String bedroom;
  String bathroom;
  String furnishing;
  
  Filter_Page_Display({
    Key? key,
    required this.property,
    required this.priceg,
    required this.pricel,
    required this.bedroom,
    required this.bathroom,
    required this.furnishing,
  }) : super(key: key);

  @override
  State<Filter_Page_Display> createState() => _Filter_Page_DisplayState();
}

class _Filter_Page_DisplayState extends State<Filter_Page_Display> {
    List<CategoryModel> filterList = [];
      bool isLoading = false;


  @override
  void initState() {
    super.initState();
    getFilterList();
  }

  void getFilterList() async {
    setState(() {
      isLoading = true;
    });
    print("${widget.property} the gameo");

     filterList = await FirebaseFirestoreHelper.instance.fliters(widget.property,widget.priceg,widget.pricel,widget.bedroom,widget.bathroom,widget.furnishing);
    //filterList = await FirebaseFirestoreHelper.instance.fliters(widget.property,widget.priceg,widget.pricel);

    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
     if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (filterList.isEmpty) {
      return Center(child: Text("No categories available"));
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        height: 306,
        
        child: GridView.builder(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.6,
            crossAxisCount: 1,
           // childAspectRatio: 1.5, // Adjust aspect ratio for better spacing
          ),
          itemCount: filterList.length,
          itemBuilder: (context, index) {
            return CategoryCard(category: filterList[index]);
          },
        ),
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
