import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final bottmBarItem=[  
    'home',
    'home_search',
    'notification',
    'chat',
    'home_mark'
  ];
  final bottmBarItem1=[  
'dart',
'dart',
'dart',
'dart',
  ];
   CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.symmetric(vertical: 15,),
      decoration: BoxDecoration(  
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [  
          BoxShadow(  
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0,3),
          ),
        ],
        
      ),
      child: Row(  
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:bottmBarItem1.map((e) => Image.asset('assets/$e.png',scale: 10,),).toList(),

      ),
    );
  }
}