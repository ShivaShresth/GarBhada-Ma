import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:renthouse/firebase_firestore/firebase_firestore.dart';
import 'package:renthouse/model/category_model.dart';
import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/pages/all_pages/facebook_url.dart';
import 'package:renthouse/provider/app_provider.dart';

class CategoryModels {
  final List<dynamic> imageUrls;
  final String id;

  CategoryModels({required this.imageUrls, required this.id});

  factory CategoryModels.fromJson(Map<String, dynamic> json) {
    return CategoryModels(
      imageUrls: json['imageUrls'] ?? '',
      id: json['id'] ?? '',
    );
  }
}

class FirebaseFirestoreHelper {
  static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Function to fetch category data
  Future<List<CategoryModels>> takePhotget() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
          .collection("cat")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection("gamer")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (!querySnapshot.exists) {
        print("Document does not exist");
        return [];
      }

      Map<String, dynamic>? data = querySnapshot.data();
      if (data != null) {
        return [CategoryModels.fromJson(data)];
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }
}
class List_Of_Operator extends StatefulWidget {
  final CategoryModel? categoryModel;
  const List_Of_Operator({super.key, this.categoryModel});

  @override
  State<List_Of_Operator> createState() => _List_Of_OperatorState();
}

class _List_Of_OperatorState extends State<List_Of_Operator> {
  List<CategoryModel> categoriesList = [];
  List<ProductModel> productModelList = [];

  List<CategoryModels> categories = [];

  @override
  void initState() {
    AppProvider appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.getUserInfoFirebase();

    getCategoryList();
    super.initState();
  }

  bool isLoading = false;

  void getCategoryList() async {
    setState(() {
      isLoading = true;
    });
    categories = await FirebaseFirestoreHelper().takePhotget();

    // // FirebaseFirestoreHelper.instance.updateTokenFromFirebase();
    // categoriesList = await FirebaseFirestoreHelper.instance.getCategories();
    // productModelList = await FirebaseFirestoreHelper.instance.getBestProducts();

    // productModelList.shuffle();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime postDate = DateTime.parse(widget.categoryModel!.date);

    String formattedDate =
        "${postDate.year}-${postDate.month.toString().padLeft(2, '0')}-${postDate.day.toString().padLeft(2, '0')}";

    return Container(
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Status",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor:
                          Colors.green, // Optional: Set the underline color
                      decorationThickness: 3,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                width: 400,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: widget.categoryModel!.isFavourite == false
                            ? Colors.red
                            : Colors.green),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 3,
                        offset: Offset(2, 2),
                      )
                    ]),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   FutureBuilder<List<CategoryModels>>(
  future: FirebaseFirestoreHelper().takePhotget(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error loading image: ${snapshot.error}');
    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
      List<dynamic> imageUrl = snapshot.data![0].imageUrls;
      if (imageUrl.isEmpty) {
        return Text('Image URL is empty.');
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
      (widget.categoryModel!.facebook=="Not Avaliable")?Image.asset("assets/a.png",height: 30,scale: 2,):    InkWell(
      onTap: (){
      Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OpenFacebook(
                                      categoryModel: widget.categoryModel,
                                    )));},
              child: Container(
                padding: EdgeInsets.all(1),
                // decoration: BoxDecoration(
                //   border: Border.all(width: 5, color: Colors.grey.shade700),
                //   shape: BoxShape.circle,
                // ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl.isNotEmpty ? imageUrl[0] : '',
                    height: 40,
                    width: 40,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }

    return Text('No data available');
  },
),

                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => OpenFacebook(
                    //                   categoryModel: widget.categoryModel,
                    //                 )));

                    //     print("Null${widget.categoryModel!.facebook}");
                    //   },
                    //   child: Padding(
                    //     padding: const EdgeInsets.only(left: 10),
                    //     child: CircleAvatar(
                    //       radius: 20,
                    //       backgroundImage:(widget.categoryModel!.facebook=="Not Avaliable")? 
                    //       //  widget
                    //       //         .categoryModel!.facebook!.isNotEmpty
                    //            NetworkImage(
                    //               "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/2021_Facebook_icon.svg/2048px-2021_Facebook_icon.svg.png")
                    //           : NetworkImage(
                    //               "https://buffer.com/library/content/images/size/w1200/2023/10/free-images.jpg"),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(child: Text("Owner")),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 10),
                    //   child: Text(
                    //     widget.categoryModel!.isFavourite == false
                    //         ? "Occupied"
                    //         : "UnOccupied",
                    //     style: TextStyle(
                    //         color: widget.categoryModel!.isFavourite == false
                    //             ? Colors.red
                    //             : Colors.green,
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 20),
                    //   ),
                    // ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: widget.categoryModel!.isFavourite
                          ? Icon(
                              Icons.lock_open_outlined,
                              color: widget.categoryModel!.isFavourite == true
                                  ? Colors.green
                                  : Colors.red,
                              size: 35,
                            )
                          : Icon(
                              Icons.lock_outline,
                              color: widget.categoryModel!.isFavourite == true
                                  ? Colors.green
                                  : Colors.red,
                              size: 35,
                            ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 20),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Information",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor:
                            Colors.green, // Optional: Set the underline color
                        decorationThickness: 3,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 6,
                      offset: Offset(2, 2),
                    )
                  ]),
              child: Container(
                color: Color.fromARGB(255, 241, 238, 237),
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(),
                      columnWidths: {
                        0: FractionColumnWidth(0.3),
                        1: FractionColumnWidth(0.7),
                      },
                      children: [
                        buildRow(['Name', 'Information'], isHeader: false),
                        buildRows([
                          'Land Mark',
                          '${widget.categoryModel!.landmark}',
                        ], isHeaders: false),
                        buildRows([
                          'Status',
                          '${widget.categoryModel!.status}',
                        ], isHeaders: false),
                        buildRows([
                          'Floor',
                          '${widget.categoryModel!.floor} floor',
                        ], isHeaders: false),
                        buildRows([
                          'Negotiable',
                          '${widget.categoryModel!.negotiable}',
                        ], isHeaders: false),
                        buildRows([
                          'Road Type',
                          '${widget.categoryModel!.roadtype}',
                        ], isHeaders: false),
                        buildRows([
                          'Furnishing',
                          '${widget.categoryModel!.furnishing}',
                        ], isHeaders: false),
                        buildRows([
                          'Type',
                          '${widget.categoryModel!.type}',
                        ], isHeaders: false),
                        buildRows([
                          'Non-Veg',
                          '${widget.categoryModel!.nonveg}',
                        ], isHeaders: false),
                        buildRows([
                          'RoadSize',
                          '${widget.categoryModel!.roadsize} feet',
                        ], isHeaders: false),
                        buildRows([
                          'Buildup(Sqr.Ft)',
                          '${widget.categoryModel!.buildupsqrft} sqrft',
                        ], isHeaders: false),
                        buildRows([
                          'Phone Number',
                          '${widget.categoryModel!.phonenumber}',
                        ], isHeaders: false),
                        buildRows([
                          'Starting Date',
                          '$formattedDate',
                        ], isHeaders: false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow buildRow(List<String> cells, {bool isHeader = false}) => TableRow(
        children: cells.map((cell) {
          final style = TextStyle(
            fontWeight: isHeader ? FontWeight.bold : FontWeight.bold,
            fontSize: 13,
          );

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
                child: Text(
              cell,
              style: style,
            )),
          );
        }).toList(),
      );
  TableRow buildRows(List<String> cells, {bool isHeaders = false}) => TableRow(
        children: cells.map((cell) {
          final style = TextStyle(
            fontWeight: isHeaders ? FontWeight.normal : FontWeight.normal,
            fontSize: 12,
          );

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
                child: Text(
              cell,
              style: style,
            )),
          );
        }).toList(),
      );
}
