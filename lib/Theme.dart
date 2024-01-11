import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle get subHeadingStyle{
  return  GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    )
  );
}

TextStyle get HeadingStyle{
  return  GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      )
  );
}

TextStyle get subTitleStyle{
  return  GoogleFonts.lato(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      )
  );
}

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF3B2A75), // Set your desired primary color
  scaffoldBackgroundColor: Color(0xfff8b3db), // Set your desired background color
  // Add more theme properties as needed
);