// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/pages/all_pages/most_visited.dart';
import 'package:renthouse/screen/detail/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    print("${widget.priceg} the ga76meo");
        print("${widget.pricel} the gameo");


     filterList = await FirebaseFirestoreHelper.instance.fliters(widget.property,widget.priceg,widget.pricel,widget.bedroom,widget.bathroom,widget.furnishing);
     
    //filterList = await FirebaseFirestoreHelper.instance.fliters(widget.property,widget.priceg,widget.pricel);

    setState(() {
      isLoading = false;
    });
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
    if (filterList.isEmpty) {
      return Center(child: Text("No categories available"));
    }

    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Colors.white,
        title: Text("Result"),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: 306,
          
          child: GridView.builder(
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.6,
              crossAxisCount: 1,
             // childAspectRatio: 1.5, // Adjust aspect ratio for better spacing
            ),
            itemCount: filterList.length,
            itemBuilder: (context, index) {
              return CategoryCard(category: filterList[index],index: index,onUpdateViewCount: updateViewCount);
            },
          ),
        ),
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
  String calculateTimeDifference(String dateString) {
    DateTime postDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(dateString);
    Duration difference = DateTime.now().difference(postDate);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 0) {
      return 'Today';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    double screenWidth=MediaQuery.of(context).size.width;
    double cardWidth=(screenWidth);
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: ()async {
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
        width: 360,
        height: 160,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 159,
                      width: 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.category.image[0],
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
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(  
                  shape: BoxShape.circle,
                  color: Colors.black26
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
}
