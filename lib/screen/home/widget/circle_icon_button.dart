import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleIconButton extends StatelessWidget {
  final String iconUrl;
  final Color color;

   CircleIconButton({super.key, required this.iconUrl, required this.color,});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(  
        color: color,
        shape: BoxShape.circle
      ),
child: Image.asset(iconUrl),
    );
  }
}