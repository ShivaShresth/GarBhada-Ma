import 'package:flutter/material.dart';
import 'package:renthouse/constants/custom_theme.dart';

class CustomRoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  const CustomRoundedButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomTheme.primaryColor,
      borderRadius: BorderRadius.circular(6),
      child: InkWell(  
        onTap: onPressed,
        borderRadius: BorderRadius.circular(6),
        child: Container(  
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 14,horizontal: 40),
          decoration: BoxDecoration(  
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(title,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }
}