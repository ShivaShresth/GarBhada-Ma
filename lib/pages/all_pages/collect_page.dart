import 'package:flutter/material.dart';
import 'package:renthouse/pages/all_pages/most_visited.dart';
import 'package:renthouse/pages/all_pages/post_rent.dart';
import 'package:renthouse/pages/all_pages/recents.dart';
import 'package:renthouse/pages/categories/best_offer.dart';
import 'package:renthouse/pages/categories/offer.dart';
import 'package:renthouse/screen/home/widget/best_offer.dart';
import 'package:renthouse/screen/home/widget/recommended_house.dart';

class Collect_Page extends StatefulWidget {
  const Collect_Page({super.key});

  @override
  State<Collect_Page> createState() => _Collect_PageState();
}

class _Collect_PageState extends State<Collect_Page> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: MediaQuery.of(context).size.height,

      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            RecommendedHouse(),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text("Recent"),
                )),
                Recents(),
          //  Best_Offer(),
            PostRent(),
            SizedBox(height: 10,),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text("Most Visited"),
                )),

            MostVisited()

            // Offer(),
          ],
        ),
      ),
    );
  }
}
