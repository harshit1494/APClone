import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color appPrimaryColor = Color(0xFF35B350);
  static const Color appPrimaryLightColor = Color(0xFFFFFFFF);
  static const Color appPrimaryColorSecondary = Color(0xFF3F3F3F);
  static const Color appGradientColor = Color(0xFF79D98E);
  static const Color appBackgroundColor = Color(0xFFF1F1F6);
  static const Color appBackgroundColorSecondary = Color(0xFFFFFFFF);
  static const Color colorSchemaSecondaryColor = Color(0xFFFFFFFF);
  static const Color appBorderColor = Color(0xFFE0E0E0);
  static const Color appTextColor = Color(0xFF2B2B2B);
  static const Color noInternetColor = Color(0xFFCC5439);
  static Color appTextColorSecondary = const Color(0xFF000000).withOpacity(0.56);
  static Color appDialogBackgroundColor = const Color(0xFFC4C4C4).withOpacity(0.2);
  static const Color appAccentTextColor = Color(0xFF999999);
  static const Color appLightAccentTextColor = Color(0xFF000099);
  static const Color appOverlineColor = Color(0xFF666666);
  static const Color appErrorColor = Color(0xFFB00020);
  static const Color appErrorBackgroundColor = Color(0xFFFBF2F4);
  static const Color appIconColor = Color(0xFF747474);
  static const Color appAccentIconColor = Color(0xFF717880);
  static const Color labelColor = Color(0xFF747474);
  static const Color appInputFillColor = Color(0xFFF2F2F2);
  static const Color snackBarBackgroundColor = Color(0xFFE1F4E5);
  static const Color appFocusInputBorderColor = Color(0xFFEAEBEC);
  static Color colorSchemaBackgroundColor = const Color(0xFFF3F3F3).withOpacity(0.5);
  static const Color colorSchemaPrimaryColor = Color(0xFF797979);
  static const Color colorSchemeOnPrimaryColor = Color(0xFFBDF3C8);
  static const Color colorSchemeOnSecondaryColor = Color(0xFFF5C1BC);
  static const Color colorSchemeOnErrorColor = Color(0xFFC25E54);
  static const Color colorPending = Color(0xFFFEB41C);

  // Dark Theme Colors
  static const Color appPrimaryColorDark = Color(0xFF00C802);
  static const Color appPrimaryLightColorDark = Color(0xFFFFFFFF);
  static const Color appPrimaryColorSecondaryDark = Color(0xFFFFFFFF);
  static const Color appGradientColorDark = Color(0xFF79D98E);
  static const Color appBackgroundColorDark = Color(0xFF181D20);
  static const Color appBackgroundColorSecondaryDark = Color(0xFF0C0C0C);
  static const Color colorSchemaSecondaryColorDark = Color(0xFFFFFFFF);
  static const Color appBorderColorDark = Color(0xFF505050);
  static const Color appTextColorDark = Color(0xFFFFFFFF);
  static Color appTextColorSecondaryDark = const Color(0xFFFFFFFF).withOpacity(0.56);
  static Color appDialogBackgroundColorDark = const Color(0xFFFFFFFF);
  static const Color appAccentTextColorDark = Color(0xFF999999);
  static const Color appLightAccentTextColorDark = Color(0xFF000099);
  static const Color appOverlineColorDark = Color(0xFF666666);
  static const Color appErrorColorDark = Color(0xFFB00020);
  static const Color appErrorBackgroundColorDark = Color(0xFF3C190A);
  static const Color appIconColorDark = Color(0xFF8D8D93);
  static const Color appAccentIconColorDark = Color(0xFF717880);
  static const Color labelColorDark = Color(0xFFB3B3B3);
  static const Color appInputFillColorDark = Color(0xFF282F35);
  static const Color snackBarBackgroundColorDark = Color(0xFF142D1A);
  static const Color appFocusInputBorderColorDark = Color(0xFFEAEBEC);
  static Color colorSchemaBackgroundColorDark = const Color(0xFF1D2124);
  static const Color colorSchemaPrimaryColorDark = Color(0xFFB3B3B3);
  static const Color colorSchemeOnPrimaryColorDark = Color(0xFF00C802);
  static const Color colorSchemeOnSecondaryColorDark = Color(0xFFFE4E02);
  static const Color colorSchemeOnErrorColorDark = Color(0xFFFE4E02);
  static const Color colorPendingDark = Color(0xFFFEB41C);

  // Helper methods
  static Color positiveColor(bool isLight) {
    return isLight ? appPrimaryColor : appPrimaryColorDark;
  }

  static const Color negativeColor = Color(0xFFC25E54);
  
  static Color primaryColorLight(bool isLight) {
    return isLight ? appPrimaryLightColor : appPrimaryLightColorDark;
  }
  
  static Color primaryColor(bool isLight) {
    return isLight ? appPrimaryColor : appPrimaryColorDark;
  }
}

