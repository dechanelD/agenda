import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{

  static const Color bluishClr = Color(0xff4e5ae8);
  static const Color yellowClr = Color(0xffffb746);
  static const Color pinkClr = Color(0xffff4667);
  static const Color white = Colors.white;
  static const primaryClr = bluishClr;
  static const darkGreyClr = Color(0xff121212);
  Color darkHeaderClr = Color(0x424242);

 static final light =  ThemeData(
   backgroundColor: white,
  primaryColor: primaryClr,
  brightness: Brightness.light
      );

 static final dark =  ThemeData(
   backgroundColor: darkGreyClr,
     primaryColor: darkGreyClr,
     brightness: Brightness.dark
      );
}

TextStyle get textHeadingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.grey[400]:Colors.grey
      )
  );
}

TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.white:Colors.black
      )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode?Colors.grey[100]:Colors.grey[600],
      )
  );
}