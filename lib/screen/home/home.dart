import 'dart:async';

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

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

// class _HomePageState extends State<HomePage> {
//   // You can have a variable to hold data for refreshing
//   bool _isRefreshing = false;

//   Future<void> _onRefresh() async {
//     setState(() {
//       _isRefreshing = true;
//     });
//     // Simulate a network call or data fetching process
//     await Future.delayed(Duration(seconds: 2));
//     // After refreshing, you can update the state or data
//     setState(() {
//       _isRefreshing = false;
//     });
//     print('Content refreshed!');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: RefreshIndicator(
//           onRefresh: _onRefresh, // Trigger refresh when pulled down
//           child: SingleChildScrollView(
//             primary: true,
//             scrollDirection: Axis.vertical,
//             physics: BouncingScrollPhysics(),
//             child: Padding(
//               padding: const EdgeInsets.only(bottom: 0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   WelcomeText(),
//                   SearchInput(),
//                   HomePages(),
//                   SizedBox(height: 40),
//                   // Optionally display a loading indicator when refreshing
//                   if (_isRefreshing) CircularProgressIndicator(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _HomePageState extends State<HomePage> {
  bool _isRefreshing = false;
  bool _isShimmerActive = true;  // Add this variable here


  @override
  void initState() {
    super.initState();
    // Set a timer to stop shimmer effect after 3 seconds
    Timer(Duration(seconds: 6), () {
      setState(() {
        _isShimmerActive = false;
      });
    });
  }
  Future<void> _onRefresh() async {
    setState(() {
      _isRefreshing = true;
      _isShimmerActive = true;  // Trigger shimmer effect on refresh
    });

    // Simulate a network call or data fetching process
    await Future.delayed(Duration(seconds: 2));

    // After refreshing, you can update the state or data
    setState(() {
      _isRefreshing = false;
      _isShimmerActive = false;  // Stop shimmer after refresh completes
    });
    print('Content refreshed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _onRefresh, // Trigger refresh when pulled down
          child: SingleChildScrollView(
            primary: true,
            scrollDirection: Axis.vertical,
            //physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WelcomeText(isShimmerActive: _isShimmerActive),  // Pass the shimmer state to WelcomeText
                  SearchInput(),
                  HomePages(),
                  SizedBox(height: 40),
                  if (_isRefreshing) CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

