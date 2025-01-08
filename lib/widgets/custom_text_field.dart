import 'package:flutter/material.dart';
import 'package:renthouse/constants/custom_theme.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String label;
  final IconData prefixIcon;
  final double bottomMargin;
  final TextInputType keyboardType;
  final int? maximumLength;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.label,
      required this.prefixIcon,
       this.bottomMargin=16,
       this.keyboardType=TextInputType.text,
      this.maximumLength,
       this.validator,
      this.controller,  
      
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.only(bottom: bottomMargin),
      child: TextFormField(  
        validator: validator,
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: (val){  

        },
        decoration: InputDecoration(  
          border: OutlineInputBorder(  
            
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(  
            )
          ),
          errorBorder: OutlineInputBorder(  
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.red),

          ),
          enabledBorder: OutlineInputBorder(  
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.grey)
          ),
          focusedBorder: OutlineInputBorder(  
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide(color: Colors.blue)
          ),
          fillColor: CustomTheme.greyColor,
          filled: true,
          hintText: hintText,
          labelText: label,
          labelStyle: TextStyle(  
            color: CustomTheme.primaryColor
          ),
          counterText: "",
          prefixIcon: Icon(prefixIcon,color:CustomTheme.primaryColor,)
        ),
        maxLength: maximumLength,
        keyboardType: keyboardType,
      ),
      
    );
  }
}
