import 'package:flutter/material.dart';
import 'custom_text_widget.dart';

Widget getRupeeSymbol(
  BuildContext context,
  TextStyle textStyle,
) {
  return CustomTextWidget(
    '₹', // Indian Rupee symbol
    textStyle,
  );
}

