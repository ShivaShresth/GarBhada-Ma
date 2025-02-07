import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  ScrollController? scrollController;
   HomePage({super.key, this.scrollController});

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

// class _HomePageState extends State<HomePage> {
//   bool _isRefreshing = false;
//   bool _isShimmerActive = true;  // Add this variable here
//     bool _isBottomBarVisible = true;

  


//   @override
//   void initState() {
//     super.initState();
//         widget.scrollController!.addListener(_scrollListener);

//     // Set a timer to stop shimmer effect after 3 seconds
//     Timer(Duration(seconds: 1), () {
//       setState(() {
//         _isShimmerActive = false;
//       });
//     });
//   }

//     void _scrollListener() {
//     if (!mounted) return; // Ensure the widget is still in the widget tree

//     if (widget.scrollController!.position.userScrollDirection == ScrollDirection.reverse) {
//       setState(() {
//         _isBottomBarVisible = false;
//       });
//     } else if (widget.scrollController!.position.userScrollDirection == ScrollDirection.forward) {
//       setState(() {
//         _isBottomBarVisible = true;
//       });
//     }

//   }
//   Future<void> _onRefresh() async {
//     setState(() {
//       _isRefreshing = true;
//       _isShimmerActive = true;  // Trigger shimmer effect on refresh
//     });

//     // Simulate a network call or data fetching process
//     await Future.delayed(Duration(seconds: 1));

//     // After refreshing, you can update the state or data
//     setState(() {
//       _isRefreshing = false;
//       _isShimmerActive = false;  // Stop shimmer after refresh completes
//     });
//     print('Content refreshed!');
//   }

//   @override
//   Widget build(BuildContext context) {
//     double height =MediaQuery.of(context).size.height;
//     double width=MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(  
//           color: Colors.white
//         ),
//         child: SafeArea(
//           child: RefreshIndicator(
//             onRefresh: _onRefresh, // Trigger refresh when pulled down
//             child: SingleChildScrollView(
//               primary: true,
//               scrollDirection: Axis.vertical,
//               //physics: BouncingScrollPhysics(),
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     WelcomeText(isShimmerActive: _isShimmerActive),  // Pass the shimmer state to WelcomeText
//                     SearchInput(),
//                     HomePages(toprent: _isShimmerActive,),
//                     //if (_isRefreshing) CircularProgressIndicator(),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// // }

class _HomePageState extends State<HomePage> {
  bool _isRefreshing = false;
  bool _isShimmerActive = true;
  bool _isBottomBarVisible = true;

  @override
  void initState() {
    super.initState();

    // Attach the scroll listener only once
    widget.scrollController!.addListener(_scrollListener);

    // Simulate the shimmer effect by updating after 1 second
    Timer(Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isShimmerActive = false;
        });
      }
    });
  }

  // Remove the scroll listener when the widget is disposed
  @override
  void dispose() {
    widget.scrollController!.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    //if (_isRefreshing) return; // Prevent refresh from being triggered continuously

    // Logic to hide or show the bottom bar based on scroll direction
    final userScrollDirection = widget.scrollController!.position.userScrollDirection;

    if (userScrollDirection == ScrollDirection.reverse) {
      if (_isBottomBarVisible) {
        // setState(() {
        //   _isBottomBarVisible = false;
        // });
      }
    } else if (userScrollDirection == ScrollDirection.forward) {
      if (!_isBottomBarVisible) {
        // setState(() {
        //   _isBottomBarVisible = true;
        // });
      }
    }
  }

  Future<void> _onRefresh() async {
    if (_isRefreshing) return;  // Prevent triggering refresh while it's already in progress

    setState(() {
      _isRefreshing = true;
      _isShimmerActive = true; // Trigger shimmer effect on refresh
    });

    // Simulate a network call or data fetching
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;   // Stop refreshing
      _isShimmerActive = false; // Stop shimmer after refresh completes
    });

    print('Content refreshed!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              controller: widget.scrollController, // Keep the custom scroll controller
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Only rebuild if shimmer effect changes
                    WelcomeText(isShimmerActive: _isShimmerActive),
                    SearchInput(),
                    HomePages(toprent: _isShimmerActive),
                    if (_isRefreshing) CircularProgressIndicator(), // Show loading indicator while refreshing
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _HomePageState extends State<HomePage> {
//   bool _isRefreshing = false;
//   bool _isShimmerActive = true;
//   bool _isBottomBarVisible = true;

//   @override
//   void initState() {
//     super.initState();

//     // Attach the scroll listener only once
//     widget.scrollController!.addListener(_scrollListener);

//     // Simulate the shimmer effect by updating after 1 second
//     Timer(Duration(seconds: 1), () {
//       if (mounted) { // Ensure that the widget is still in the widget tree
//         setState(() {
//           _isShimmerActive = false;
//         });
//       }
//     });
//   }

//   // Remove the scroll listener when the widget is disposed
//   @override
//   void dispose() {
//     widget.scrollController!.removeListener(_scrollListener);
//     super.dispose();
//   }

//   void _scrollListener() {
//     // Prevent refresh from being triggered continuously
//     if (_isRefreshing) return;

//     // Logic to hide or show bottom bar based on scroll direction
//     if (widget.scrollController!.position.userScrollDirection == ScrollDirection.reverse) {
//       if (_isBottomBarVisible) {
//         setState(() {
//           _isBottomBarVisible = false;
//         });
//       }
//     } else if (widget.scrollController!.position.userScrollDirection == ScrollDirection.forward) {
//       if (!_isBottomBarVisible) {
//         setState(() {
//           _isBottomBarVisible = true;
//         });
//       }
//     }
//   }

//   Future<void> _onRefresh() async {
//     if (_isRefreshing) return;  // Prevent triggering refresh while it's already in progress

//     setState(() {
//       _isRefreshing = true;
//       _isShimmerActive = true; // Trigger shimmer effect on refresh
//     });

//     // Simulate a network call or data fetching
//     await Future.delayed(Duration(seconds: 2));

//     setState(() {
//       _isRefreshing = false;   // Stop refreshing
//       _isShimmerActive = false; // Stop shimmer after refresh completes
//     });

//     print('Content refreshed!');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//         ),
//         child: SafeArea(
//           child: RefreshIndicator(
//             onRefresh: _onRefresh,
//             child: SingleChildScrollView(
//               controller: widget.scrollController, // Keep the custom scroll controller
//               child: Padding(
//                 padding: const EdgeInsets.only(bottom: 0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     WelcomeText(isShimmerActive: _isShimmerActive),
//                     SearchInput(),
//                     HomePages(toprent: _isShimmerActive),
//                     if (_isRefreshing) CircularProgressIndicator(), // Show loading indicator while refreshing
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
