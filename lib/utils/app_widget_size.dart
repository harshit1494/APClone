import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AppWidgetSize {
  static double get dimen_1 => 1.w;
  static double get dimen_2 => 2.w;
  static double get dimen_3 => 3.w;
  static double get dimen_4 => 4.w;
  static double get dimen_5 => 5.w;
  static double get dimen_6 => 6.w;
  static double get dimen_8 => 8.w;
  static double get dimen_10 => 10.w;
  static double get dimen_12 => 12.w;
  static double get dimen_13 => 13.w;
  static double get dimen_14 => 14.w;
  static double get dimen_15 => 15.w;
  static double get dimen_16 => 16.w;
  static double get dimen_18 => 18.w;
  static double get dimen_20 => 20.w;
  static double get dimen_22 => 22.w;
  static double get dimen_24 => 24.w;
  static double get dimen_25 => 25.w;
  static double get dimen_30 => 30.w;
  static double get dimen_32 => 32.w;
  static double get dimen_35 => 35.w;
  static double get dimen_38 => 38.w;
  static double get dimen_40 => 40.w;
  static double get dimen_45 => 45.w;
  static double get dimen_48 => 48.w;
  static double get dimen_50 => 50.w;
  static double get dimen_54 => 54.w;
  static double get dimen_60 => 60.w;
  static double get dimen_64 => 64.w;
  static double get dimen_66 => 66.w;
  static double get dimen_70 => 70.w;
  static double get dimen_80 => 80.w;
  static double get dimen_85 => 85.w;
  static double get dimen_90 => 90.w;
  static double get dimen_7 => 7.w;
  static double get dimen_100 => 100.w;
  static double get dimen_110 => 110.w;
  static double get dimen_120 => 120.w;
  static double get dimen_150 => 150.w;
  static double get dimen_210 => 210.w;
  static double get dimen_240 => 240.w;
  static double get dimen_280 => 280.w;
  
  static double get subtitle1Size => 28.w;
  static double get subtitle2Size => 22.w;
  static double get buttonSize => 18.w;
  static double get overlineSize => 16.w;
  static double get captionSize => 14.w;
  static double get fontSize10 => 10.w;
  static double get fontSize12 => 12.w;
  static double get fontSize13 => 13.w;
  static double get fontSize14 => 14.w;
  static double get fontSize15 => 15.w;
  static double get fontSize16 => 16.w;
  static double get fontSize18 => 18.w;
  static double get fontSize22 => 22.w;
  static double get fontSize28 => 28.w;
  static double get headline1Size => 38.w;
  static double get headline2Size => 28.w;
  static double get headline3Size => 22.w;
  static double get headline4Size => 18.w;
  static double get headline5Size => 16.w;
  static double get headline6Size => 14.w;
  static double get bodyText1Size => 12.w;
  static double get bodyText2Size => 10.w;
  static double get inputLabelSize => 13.w;
  static double get buttonHeight => 45.h;
  static BorderRadius get buttonBorderRadius => BorderRadius.circular(6).r;
  
  static double fullHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
  
  static double fullWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }
  
  static double screenHeight(BuildContext context, {double dividedBy = 1}) {
    return MediaQuery.of(context).size.height / dividedBy;
  }
}
