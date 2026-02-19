import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

// Light theme colors
const Color lightAppPrimaryColor = Color(0xFF35B350);
const Color lightAppBackgroundColorSecondary = Color(0xFFFFFFFF);
const Color lightAppTextColor = Color(0xFF2B2B2B);
const Color lightAppTextColorSecondary = Color(0xFF000000);
const Color lightAppPrimaryColorSecondary = Color(0xFF3F3F3F);
const Color lightAppGradientColor = Color(0xFF79D98E);
const Color lightAppBorderColor = Color(0xFFE0E0E0);
const Color lightAppIconColor = Color(0xFF747474);
const Color lightLabelColor = Color(0xFF747474);
const Color lightColorSchemaPrimaryColor = Color(0xFF797979);
const Color lightColorSchemeOnPrimaryColor = Color(0xFFBDF3C8);
const Color lightColorSchemaBackgroundColor = Color(0xFFF3F3F3);

// Dark theme colors
const Color darkAppPrimaryColor = Color(0xFF00C802);
const Color darkAppBackgroundColorSecondary = Color(0xFF0C0C0C);
const Color darkAppTextColor = Color(0xFFFFFFFF);
const Color darkAppPrimaryColorSecondary = Color(0xFFFFFFFF);
const Color darkAppGradientColor = Color(0xFF79D98E);
const Color darkAppBorderColor = Color(0xFF505050);
const Color darkAppIconColor = Color(0xFF8D8D93);
const Color darkLabelColor = Color(0xFFB3B3B3);
const Color darkColorSchemaPrimaryColor = Color(0xFFB3B3B3);
const Color darkColorSchemeOnPrimaryColor = Color(0xFF00C802);
const Color darkColorSchemaBackgroundColor = Color(0xFF1D2124);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Arihant App',
          debugShowCheckedModeBanner: false,
          theme: _buildLightTheme(),
          darkTheme: _buildDarkTheme(),
          themeMode: ThemeMode.light,
          home: const LoginScreen(),
        );
      },
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      primaryColor: lightAppPrimaryColor,
      scaffoldBackgroundColor: lightAppBackgroundColorSecondary,
      fontFamily: 'futura',
      primaryTextTheme: TextTheme(
        titleLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: lightAppPrimaryColor,
        ),
        headlineSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: lightAppPrimaryColor,
        ),
        headlineMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: lightAppPrimaryColor,
        ),
        displaySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: lightAppPrimaryColor,
        ),
        displayMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: lightAppPrimaryColor,
        ),
        displayLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 38.w,
          fontWeight: FontWeight.w700,
          color: lightAppPrimaryColor,
        ),
        titleMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: lightAppPrimaryColorSecondary,
        ),
        titleSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: lightAppPrimaryColorSecondary,
        ),
        labelLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: lightAppPrimaryColorSecondary,
        ),
        labelSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: lightAppPrimaryColorSecondary,
        ),
        bodySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: lightAppPrimaryColorSecondary,
        ),
        bodyMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 10.w,
          fontWeight: FontWeight.w500,
          color: lightAppPrimaryColor,
        ),
        bodyLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 12.w,
          fontWeight: FontWeight.w500,
          color: lightAppPrimaryColor,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColor,
        ),
        headlineSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColor,
        ),
        headlineMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: lightAppTextColor,
        ),
        displaySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: lightAppTextColor,
        ),
        displayMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColor,
        ),
        displayLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 38.w,
          fontWeight: FontWeight.w700,
          color: lightAppTextColor,
        ),
        titleMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColorSecondary.withOpacity(0.56),
        ),
        titleSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: lightAppTextColorSecondary.withOpacity(0.56),
        ),
        labelLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          color: lightAppTextColorSecondary.withOpacity(0.56),
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColorSecondary.withOpacity(0.56),
        ),
        labelSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColorSecondary.withOpacity(0.56),
        ),
        bodyMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 10.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColor,
        ),
        bodyLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 12.w,
          fontWeight: FontWeight.w400,
          color: lightAppTextColor,
        ),
      ),
      dividerColor: lightAppBorderColor,
      iconTheme: const IconThemeData(
        color: lightAppIconColor,
      ),
      primaryIconTheme: const IconThemeData(
        color: lightAppPrimaryColorSecondary,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.white,
        error: const Color(0xFFFBF2F4),
        errorContainer: const Color(0xFFB00020),
        surface: lightColorSchemaBackgroundColor.withOpacity(0.5),
        primary: lightColorSchemaPrimaryColor,
        onPrimary: lightColorSchemeOnPrimaryColor,
        onSurface: lightAppGradientColor,
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xFFF1F1F6),
        elevation: 0.0,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFFE1F4E5),
      ),
      shadowColor: Colors.transparent,
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      primaryColor: darkAppPrimaryColor,
      scaffoldBackgroundColor: darkAppBackgroundColorSecondary,
      fontFamily: 'futura',
      primaryTextTheme: TextTheme(
        titleLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: darkAppPrimaryColor,
        ),
        headlineSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: darkAppPrimaryColor,
        ),
        headlineMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: darkAppPrimaryColor,
        ),
        displaySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: darkAppPrimaryColor,
        ),
        displayMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: darkAppPrimaryColor,
        ),
        displayLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 38.w,
          fontWeight: FontWeight.w700,
          color: darkAppPrimaryColor,
        ),
        titleMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: darkAppPrimaryColorSecondary,
        ),
        titleSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: darkAppPrimaryColorSecondary,
        ),
        labelLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: darkAppPrimaryColorSecondary,
        ),
        labelSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: darkAppPrimaryColorSecondary,
        ),
        bodySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: darkAppPrimaryColorSecondary,
        ),
        bodyMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 10.w,
          fontWeight: FontWeight.w500,
          color: darkAppPrimaryColor,
        ),
        bodyLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 12.w,
          fontWeight: FontWeight.w500,
          color: darkAppPrimaryColor,
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor,
        ),
        headlineSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor,
        ),
        headlineMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          fontWeight: FontWeight.w500,
          color: darkAppTextColor,
        ),
        displaySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: darkAppTextColor,
        ),
        displayMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor,
        ),
        displayLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 38.w,
          fontWeight: FontWeight.w700,
          color: darkAppTextColor,
        ),
        titleMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 28.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor.withOpacity(0.56),
        ),
        titleSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 22.w,
          fontWeight: FontWeight.w500,
          color: darkAppTextColor.withOpacity(0.56),
        ),
        labelLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 18.w,
          color: darkAppTextColor.withOpacity(0.56),
          fontWeight: FontWeight.w500,
        ),
        bodySmall: TextStyle(
          letterSpacing: 0,
          fontSize: 14.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor.withOpacity(0.56),
        ),
        labelSmall: TextStyle(
          letterSpacing: 0,
          fontSize: 16.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor.withOpacity(0.56),
        ),
        bodyMedium: TextStyle(
          letterSpacing: 0,
          fontSize: 10.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor,
        ),
        bodyLarge: TextStyle(
          letterSpacing: 0,
          fontSize: 12.w,
          fontWeight: FontWeight.w400,
          color: darkAppTextColor,
        ),
      ),
      dividerColor: darkAppBorderColor,
      iconTheme: const IconThemeData(
        color: darkAppIconColor,
      ),
      primaryIconTheme: const IconThemeData(
        color: darkAppPrimaryColorSecondary,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.white,
        error: const Color(0xFF3C190A),
        errorContainer: const Color(0xFFB00020),
        surface: darkColorSchemaBackgroundColor,
        primary: darkColorSchemaPrimaryColor,
        onPrimary: darkColorSchemeOnPrimaryColor,
        onSurface: darkAppGradientColor,
        brightness: Brightness.dark,
      ),
      appBarTheme: const AppBarTheme(
        color: Color(0xFF181D20),
        elevation: 0.0,
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: Color(0xFF142D1A),
      ),
      shadowColor: darkAppBackgroundColorSecondary,
    );
  }
}
