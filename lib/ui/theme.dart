import 'package:flutter/material.dart';

class Themes{

  static const Color bluishClr = Color(0xff4e5ae8);
  static const Color yellowClr = Color(0xffffb746);
  static const Color pinkClr = Color(0xffff4667);
  static const Color white = Colors.white;
  static const primaryClr = bluishClr;
  static const darkGreyClr = Color(0xff121212);
  Color darkHeaderClr = Color(0x424242);

 static final light =  ThemeData(
  primaryColor: primaryClr,
  brightness: Brightness.light
      );

 static final dark =  ThemeData(
     primaryColor: darkGreyClr,
     brightness: Brightness.dark
      );
}