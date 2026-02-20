import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class AppWidgetSize {
  static double dimen_1 = 1.w;
  static double dimen_2 = 2.w;
  static double dimen_3 = 3.w;
  static double dimen_4 = 4.w;
  static double dimen_5 = 5.w;
  static double dimen_6 = 6.w;
  static double dimen_8 = 8.w;
  static double dimen_10 = 10.w;
  static double dimen_12 = 12.w;
  static double dimen_13 = 13.w;
  static double dimen_14 = 14.w;
  static double dimen_15 = 15.w;
  static double dimen_16 = 16.w;
  static double dimen_18 = 18.w;
  static double dimen_20 = 20.w;
  static double dimen_22 = 22.w;
  static double dimen_24 = 24.w;
  static double dimen_25 = 25.w;
  static double dimen_30 = 30.w;
  static double dimen_32 = 32.w;
  static double dimen_35 = 35.w;
  static double dimen_38 = 38.w;
  static double dimen_40 = 40.w;
  static double dimen_48 = 48.w;
  static double dimen_50 = 50.w;
  static double dimen_54 = 54.w;
  static double dimen_60 = 60.w;
  static double dimen_64 = 64.w;
  static double dimen_66 = 66.w;
  static double dimen_70 = 70.w;
  static double dimen_80 = 80.w;
  static double dimen_85 = 85.w;
  static double dimen_90 = 90.w;
  static double dimen_7 = 7.w;
  static double dimen_100 = 100.w;
  static double dimen_110 = 110.w;
  static double dimen_120 = 120.w;
  static double dimen_150 = 150.w;
  static double dimen_210 = 210.w;
  static double dimen_240 = 240.w;
  static double dimen_280 = 280.w;
  
  static double subtitle1Size = 28.w;
  static double subtitle2Size = 22.w;
  static double buttonSize = 18.w;
  static double overlineSize = 16.w;
  static double captionSize = 14.w;
  static double fontSize10 = 10.w;
  static double fontSize12 = 12.w;
  static double fontSize13 = 13.w;
  static double fontSize14 = 14.w;
  static double fontSize15 = 15.w;
  static double fontSize16 = 16.w;
  static double fontSize18 = 18.w;
  static double fontSize22 = 22.w;
  static double fontSize28 = 28.w;
  static double headline1Size = 38.w;
  static double headline2Size = 28.w;
  static double headline3Size = 22.w;
  static double headline4Size = 18.w;
  static double headline5Size = 16.w;
  static double headline6Size = 14.w;
  static double bodyText1Size = 12.w;
  static double bodyText2Size = 10.w;
  static double inputLabelSize = 13.w;
  static double buttonHeight = 45.h;
  static BorderRadius buttonBorderRadius = BorderRadius.circular(6).r;
  
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
