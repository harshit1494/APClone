import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../models/symbols_model.dart';
import 'label_border_text_widget.dart';

class FandOTag extends StatelessWidget {
  final Symbols symbolItem;
  final bool showTag;
  final bool showExpiry;
  final bool showWeekly;
  final bool showSlice;
  final bool showMtf;
  final bool removeLeftPadding;

  const FandOTag(
    this.symbolItem, {
    Key? key,
    this.showExpiry = true,
    this.showTag = true,
    this.showWeekly = true,
    this.showSlice = false,
    this.showMtf = false,
    this.removeLeftPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    Color backGroundColor = isLight
        ? const Color(0xFFF2F2F2)
        : const Color(0xFF282F35);
    Color textColor = isLight
        ? const Color(0xFF797979)
        : const Color(0xFFFFFFFF);

    return Row(
      children: [
        if (showTag)
          Padding(
            padding: EdgeInsets.only(
              left: removeLeftPadding ? 0 : 4.0,
              right: 4,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: LabelBorderWidget(
                text: symbolItem.exc ?? '',
                textColor: textColor,
                backgroundColor: backGroundColor,
                borderColor: backGroundColor,
                fontSize: AppWidgetSize.fontSize10,
                margin: EdgeInsets.all(
                  removeLeftPadding ? 0 : AppWidgetSize.dimen_1,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

