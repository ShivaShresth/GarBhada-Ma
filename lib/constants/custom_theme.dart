import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';

class CustomTheme{  
static final MaterialColor primaryColor=
generateMaterialColor(color: Color(0xFF0b47a9));
static final Color lightBlueColor=Color(0xFF00ccff);
static const Color greyColor=Color(0xFFDFDFDF);
static final BoxShadow shadow=BoxShadow(  
  blurRadius: 10,
  offset: Offset(2, 2),
  color: Colors.grey.shade200
);
}               