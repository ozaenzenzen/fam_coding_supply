import 'package:fam_coding_supply/logic/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeCS {
  static ThemeData theme = ThemeData();
  static appThemeInit() {
    theme = theme.copyWith(
      // backgroundColor: Colors.white,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: AppColorCS.primary,
        secondary: AppColorCS.primary,
        background: Colors.white,
        // secondary: AppColorCS.secondary,
        // secondaryVariant: ColorUI.secondaryVariant,
      ),
      primaryColor: AppColorCS.primary,
      scaffoldBackgroundColor: Colors.white,
      unselectedWidgetColor: const Color(0xffb5b5b5),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.inter(
          fontSize: 36.sp,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        displayMedium: GoogleFonts.inter(
          fontSize: 25.sp,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        displaySmall: GoogleFonts.inter(
          fontSize: 21.sp,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: 18.sp,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 14.sp,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16.sp,
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 13.sp,
          color: Colors.black,
          fontStyle: FontStyle.normal,
        ),
      ),
      // textTheme: TextTheme(
      //   headline1: GoogleFonts.inter(
      //     fontSize: 36.sp,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   headline2: GoogleFonts.inter(
      //     fontSize: 25.sp,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   headline3: GoogleFonts.inter(
      //     fontSize: 21.sp,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   headline4: GoogleFonts.inter(
      //     fontSize: 18.sp,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   headline5: GoogleFonts.inter(
      //     fontSize: 16.sp,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   headline6: GoogleFonts.inter(
      //     fontSize: 14.sp,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   bodyText1: GoogleFonts.inter(
      //     fontSize: 16.sp,
      //     color: Colors.black,
      //     fontWeight: FontWeight.w500,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   bodyText2: GoogleFonts.inter(
      //     fontSize: 14.sp,
      //     fontWeight: FontWeight.w500,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      //   caption: GoogleFonts.inter(
      //     fontSize: 13.sp,
      //     color: Colors.black,
      //     fontStyle: FontStyle.normal,
      //   ),
      // ),
    );
  }
}
