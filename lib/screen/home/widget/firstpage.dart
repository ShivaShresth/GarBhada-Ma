// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:renthouse/model/product_model.dart';
import 'package:renthouse/pages/all_pages/collect_page.dart';
import 'package:renthouse/pages/categories/best_offer.dart';
import 'package:renthouse/provider/app_provider.dart';
import 'package:renthouse/screen/home/widget/best_offer.dart';
import 'package:renthouse/screen/home/widget/near.dart';
import 'package:renthouse/screen/home/widget/recent.dart';
import 'package:renthouse/screen/home/widget/recommended_house.dart';

class HomePages extends StatefulWidget {
  bool toprent;
   HomePages({
    Key? key,
    required this.toprent,
  }) : super(key: key);

  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<String> tabs = ["Popular", "Most Visited", "Recent", "Near"];
  int current = 0;
  List<ProductModel> productByCategoryList = [];
  List<ProductModel> productByCategoryList2 = [];

  void navigateToTab(int index) {
    setState(() {
      current = index;
    });
  }

  double changePositionedOfLine() {
    switch (current) {
      case 0:
        return 0;
      case 1:
        return 78;
      case 2:
        return 192;
      case 3:
        return 263;
      default:
        return 0;
    }
  }

  double changeContainerWidth() {
    switch (current) {
      case 0:
        return 65;
      case 1:
        return 100;
      case 2:
        return 60;
      case 3:
        return 70;
      default:
        return 0;
    }
  }

  void filterByBrand(List<String> brands) {
    if (brands.isEmpty) {
      productByCategoryList2 = productByCategoryList;
    } else {
      List<String> lowerCaseBrands =
          brands.map((brand) => brand.toLowerCase()).toList();
      productByCategoryList2 = productByCategoryList
          .where((product) =>
              lowerCaseBrands.contains(product.name?.toLowerCase()))
          .toList();
    }
  }

  double getContainerHeight() {
    switch (current) {
      case 0: // Collect Page
        return MediaQuery.of(context).size.height / 0.63;
      case 1: // Best Offer Page
        return MediaQuery.of(context).size.height / 1.5; // Example height
      case 2: // Recent Page
        return MediaQuery.of(context).size.height / 1.4; // Example height
      case 3: // Near Page
        return MediaQuery.of(context).size.height / 1.3; // Example height
      default:
        return MediaQuery.of(context).size.height / 1.6; // Default height
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Container(
      width: size.width,
      height: getContainerHeight(),
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            height: size.height * 0.05,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    width: size.width,
                    height: size.height * 0.04,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigateToTab(index);
                            filterByBrand([tabs[index]]);
                            print("Selected Tab: ${tabs[index]}");
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 6.0,
                            ),
                            child: Text(
                              tabs[index],
                              style: TextStyle(
                                color: current == index
                                    ? Colors.black
                                    : Colors.black,
                                fontWeight: current == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                AnimatedPositioned(
                  bottom: 0,
                  left: changePositionedOfLine(),
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: Duration(milliseconds: 500),
                  child: AnimatedContainer(
                    curve: Curves.fastLinearToSlowEaseIn,
                    margin: EdgeInsets.only(left: 10),
                    duration: Duration(milliseconds: 500),
                    width: changeContainerWidth(),
                    height: size.height * 0.009,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                color: Colors.white,
                child: Column(
                  children: [
                    if (current == 0) Collect_Page(toprent: widget.toprent,),
                    if (current == 1) Best_Offer(),
                    if (current == 2) Recent(),
                    if (current == 3) Near(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
