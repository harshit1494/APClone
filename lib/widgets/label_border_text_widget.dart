import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';

class LabelBorderWidget extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final TextAlign? textAlign;
  final double borderRadius;
  final Color? backgroundColor;
  final double borderWidth;
  final Color? borderColor;
  final bool showNSETag;
  final bool isBold;
  final Widget? child;
  final VoidCallback? onTap;

  const LabelBorderWidget({
    Key? key,
    this.text,
    this.textColor,
    this.fontSize,
    this.margin,
    this.padding,
    this.textAlign,
    this.borderRadius = 4,
    this.backgroundColor,
    this.borderWidth = 0.7,
    this.borderColor,
    this.showNSETag = true,
    this.isBold = false,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ??
        Theme.of(context).inputDecorationTheme.fillColor ??
        Theme.of(context).dividerColor;

    Widget content = child ??
        (showNSETag
            ? Text(
                text ?? '',
                textAlign: textAlign ?? TextAlign.center,
                style: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  color: textColor,
                  fontSize: fontSize ?? AppWidgetSize.fontSize10,
                  fontWeight: isBold ? FontWeight.w500 : null,
                ),
              )
            : Container());

    Widget container = Container(
      alignment: Alignment.center,
      margin: margin ?? EdgeInsets.all(3.w),
      padding: padding ?? EdgeInsets.only(left: 2.w, right: 2.w, top: 1.w, bottom: 1.w),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          color: borderColor ?? bgColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: content,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}

