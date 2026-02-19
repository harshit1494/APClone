import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String title;
  final TextStyle? style;
  final TextOverflow textOverflow;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;

  const CustomTextWidget(
    this.title,
    this.style, {
    Key? key,
    this.padding,
    this.textOverflow = TextOverflow.visible,
    this.textAlign = TextAlign.justify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Text(
        title,
        style: style,
        overflow: textOverflow,
        textAlign: textAlign,
      ),
    );
  }
}

