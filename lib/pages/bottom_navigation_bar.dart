import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:renthouse/constants/custom_theme.dart';
import 'package:renthouse/pages/add_product._page.dart';
import 'package:renthouse/pages/all_pages/favourite_screen.dart';
import 'package:renthouse/pages/all_pages/pricing.dart';
import 'package:renthouse/pages/singup.dart';
import 'package:renthouse/screen/home/home.dart';
import 'package:renthouse/pages/categories/best_offer.dart';
import 'package:renthouse/pages/account_screen.dart';

class Bottom_Navigation_Bar extends StatefulWidget {
  const Bottom_Navigation_Bar({super.key});

  @override
  State<Bottom_Navigation_Bar> createState() => _Bottom_Navigation_BarState();
}

class _Bottom_Navigation_BarState extends State<Bottom_Navigation_Bar> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(),
          FavouriteScreen(),
          AddProductPage(),
          Pricing(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavyBar(
        containerHeight: 70,
        selectedIndex: _selectedIndex,
        items: [
          BottomNavyBarItem(
              icon: Icon(Icons.home_outlined),
              title: Text("Home"),
              activeColor: CustomTheme.primaryColor),
          BottomNavyBarItem(
            icon: Icon(Icons.favorite_outline),
            title: Text("Favorites"),
            activeColor: CustomTheme.primaryColor,
          ),
          BottomNavyBarItem(
              icon: Icon(Icons.add),
              title: Text("Add"),
              activeColor: CustomTheme.primaryColor),
          BottomNavyBarItem(
              icon: Icon(Icons.chat_outlined),
              title: Text("Chat"),
              activeColor: CustomTheme.primaryColor),
          BottomNavyBarItem(
              icon: Icon(Icons.person_2_outlined),
              title: Text("Profile"),
              activeColor: CustomTheme.primaryColor),
        ],
        onItemSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}
