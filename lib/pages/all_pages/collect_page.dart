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
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,top: 14),
                  child: Text("Top Room Rent",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14), ),
                )),
            RecommendedHouse(),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 14,top: 14),
                  child: Text("Recent",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                )),
                Recents(),
          //  Best_Offer(),
            PostRent(),
            SizedBox(height: 0,),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,top: 0,bottom: 6),
                  child: Text("Most Visited",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
                )),

            MostVisited()

            // Offer(),
          ],
        ),
      ),
    );
  }
}
