import 'package:flutter/material.dart';

Widget getRupeeSymbol(
  BuildContext context,
  TextStyle textStyle,
) {
  return Text(
    '\u20B9',
    style: textStyle.copyWith(
      // Match Funds screen implementation for consistent web/app rendering.
      fontFamily: 'Arial',
    ),
  );
}

