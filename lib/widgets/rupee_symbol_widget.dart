import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

Widget getRupeeSymbol(
  BuildContext context,
  TextStyle textStyle,
) {
  return CustomTextWidget(
    '\u20B9', // Unicode for Indian Rupee symbol
    textStyle,
  );
}

