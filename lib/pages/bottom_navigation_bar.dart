import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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

// class _Bottom_Navigation_BarState extends State<Bottom_Navigation_Bar> {
//   final PageController _pageController = PageController();
//   int _selectedIndex = 0;
//     ScrollController? scrollController;
//   bool _isBottomBarVisible = true;

  
//   @override
//   void initState() {
//     super.initState();
//     scrollController = ScrollController();
//     scrollController!.addListener(_scrollListener);
//   }

//   @override
//   void dispose() {
//     scrollController!.removeListener(_scrollListener);
//     scrollController!.dispose();
//     super.dispose();
//   }

//    void _scrollListener() {
//     if (!mounted) return; // Ensure the widget is still in the widget tree

//     if (scrollController!.position.userScrollDirection == ScrollDirection.reverse) {
//       setState(() {
//         _isBottomBarVisible = false;
//       });
//     } else if (scrollController!.position.userScrollDirection == ScrollDirection.forward) {
//       setState(() {
//         _isBottomBarVisible = true;
//       });
//     }

//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//           HomePage(scrollController:scrollController ,),
//           FavouriteScreen(),
//           AddProductPage(),
//           Pricing(),
//           AccountScreen(),
//         ],
//       ),
//       bottomNavigationBar: Visibility(
//         visible: _isBottomBarVisible,
//         child: BottomNavyBar(
//           backgroundColor: Colors.grey.shade200,
//           shadowColor: Colors.black,
//           showElevation: true,
//           containerHeight: 70,
//           selectedIndex: _selectedIndex,
//           items: [
//             BottomNavyBarItem(
//                 icon: Icon(Icons.home_outlined,color: Colors.black,),
//                 title: Text("Home",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
//                 activeColor: CustomTheme.primaryColor),
//             BottomNavyBarItem(
//               icon: Icon(Icons.favorite_outline,color: Colors.black,),
//               title: Text("Favorites",style: TextStyle(color: Colors.black),),
//               activeColor: CustomTheme.primaryColor,
//             ),
//             BottomNavyBarItem(
//                 icon: Icon(Icons.add,color: Colors.black,),
//                 title: Text("Add",style: TextStyle(color: Colors.black),),
//                 activeColor: CustomTheme.primaryColor),
//             BottomNavyBarItem(
//                 icon: Icon(Icons.chat_outlined,color: Colors.black,),
//                 title: Text("Pricing",style: TextStyle(color: Colors.black),),
//                 activeColor: CustomTheme.primaryColor),
//             BottomNavyBarItem(
//                 icon: Icon(Icons.settings,color: Colors.black,),
//                 title: Text("Setting",style: TextStyle(color: Colors.black),),
//                 activeColor: CustomTheme.primaryColor),
//           ],
//           onItemSelected: (index) {
//             setState(() {
//               _selectedIndex = index;
//             });
//             _pageController.jumpToPage(index);
//           },
//         ),
//       ),
//     );
//   }
// }

class _Bottom_Navigation_BarState extends State<Bottom_Navigation_Bar> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;
  ScrollController? scrollController;
  ValueNotifier<bool> _isBottomBarVisibleNotifier = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollController!.removeListener(_scrollListener);
    scrollController!.dispose();
    _isBottomBarVisibleNotifier.dispose();
    super.dispose();
  }

  void _scrollListener() {
    bool isScrollingDown = scrollController!.position.userScrollDirection == ScrollDirection.reverse;
    bool isScrollingUp = scrollController!.position.userScrollDirection == ScrollDirection.forward;

    if (isScrollingDown) {
      // Hide the bottom bar when scrolling down
      if (_isBottomBarVisibleNotifier.value) {
        _isBottomBarVisibleNotifier.value = false;
      }
    } else if (isScrollingUp) {
      // Show the bottom bar when scrolling up
      if (!_isBottomBarVisibleNotifier.value) {
        _isBottomBarVisibleNotifier.value = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomePage(scrollController: scrollController),
          FavouriteScreen(),
          AddProductPage(),
          Pricing(),
          AccountScreen(),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: _isBottomBarVisibleNotifier,
        builder: (context, isBottomBarVisible, child) {
          return Visibility(
            visible: isBottomBarVisible,  // This controls visibility
            child: BottomNavyBar(
              backgroundColor: Colors.grey.shade200,
              shadowColor: Colors.black,
              showElevation: true,
              containerHeight: 70,
              selectedIndex: _selectedIndex,
              items: [
                BottomNavyBarItem(
                    icon: Icon(Icons.home_outlined, color: Colors.black),
                    title: Text("Home", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                    activeColor: CustomTheme.primaryColor),
                BottomNavyBarItem(
                  icon: Icon(Icons.favorite_outline, color: Colors.black),
                  title: Text("Favorites", style: TextStyle(color: Colors.black)),
                  activeColor: CustomTheme.primaryColor,
                ),
                BottomNavyBarItem(
                    icon: Icon(Icons.add, color: Colors.black),
                    title: Text("Add", style: TextStyle(color: Colors.black)),
                    activeColor: CustomTheme.primaryColor),
                BottomNavyBarItem(
                    icon: Icon(Icons.chat_outlined, color: Colors.black),
                    title: Text("Pricing", style: TextStyle(color: Colors.black)),
                    activeColor: CustomTheme.primaryColor),
                BottomNavyBarItem(
                    icon: Icon(Icons.settings, color: Colors.black),
                    title: Text("Setting", style: TextStyle(color: Colors.black)),
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
        },
      ),
    );
  }
}
