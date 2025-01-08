import 'package:flutter/material.dart';
import 'package:renthouse/screen/home/widget/best_offer.dart';
import 'package:renthouse/screen/home/widget/categories.dart';
import 'package:renthouse/screen/home/widget/custom_app_bar.dart';
import 'package:renthouse/screen/home/widget/custom_bottom_navigation_bar.dart';
import 'package:renthouse/screen/home/widget/firstpage.dart';
import 'package:renthouse/screen/home/widget/recommended_house.dart';
import 'package:renthouse/screen/home/widget/search_input.dart';
import 'package:renthouse/screen/home/widget/tab_bar.dart';
import 'package:renthouse/screen/home/widget/welcome_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: Theme.of(context).backgroundColor,
      //appBar: CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
         primary: true,
          
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),  
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: Column( 
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                WelcomeText(),
                SearchInput(),
                HomePages(),
                SizedBox(height: 40,)
             
              ],
            ),
          ),
        ),
      ),
     
    );
  }
}