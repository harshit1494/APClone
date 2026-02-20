import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import 'custom_text_widget.dart';

class ScrollCircularButtonToggleWidget extends StatefulWidget {
  final String value;
  final List<String> toggleButtonlist;
  final Function(String) toggleButtonOnChanged;
  final Color activeButtonColor;
  final Color activeTextColor;
  final Color inactiveButtonColor;
  final Color inactiveTextColor;
  final EdgeInsets? marginEdgeInsets;
  final EdgeInsets? paddingEdgeInsets;
  final bool isBorder;
  final Color? borderColor;
  final double fontSize;
  final double spacing;

  const ScrollCircularButtonToggleWidget({
    Key? key,
    required this.value,
    required this.toggleButtonlist,
    required this.toggleButtonOnChanged,
    required this.activeButtonColor,
    required this.activeTextColor,
    required this.inactiveButtonColor,
    required this.inactiveTextColor,
    this.marginEdgeInsets,
    this.paddingEdgeInsets,
    this.isBorder = true,
    this.borderColor,
    this.fontSize = 15,
    this.spacing = 8,
  }) : super(key: key);

  @override
  State<ScrollCircularButtonToggleWidget> createState() =>
      _ScrollCircularButtonToggleWidgetState();
}

class _ScrollCircularButtonToggleWidgetState
    extends State<ScrollCircularButtonToggleWidget> {
  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.toggleButtonlist.map((item) {
          final isSelected = item == widget.value;
          return GestureDetector(
            onTap: () {
              widget.toggleButtonOnChanged(item);
            },
            child: Container(
              margin: widget.marginEdgeInsets ??
                  EdgeInsets.only(
                    right: widget.spacing.w,
                    top: AppWidgetSize.dimen_6,
                  ),
              padding: widget.paddingEdgeInsets ??
                  EdgeInsets.fromLTRB(
                    AppWidgetSize.dimen_14,
                    AppWidgetSize.dimen_6,
                    AppWidgetSize.dimen_14,
                    AppWidgetSize.dimen_6,
                  ),
              decoration: BoxDecoration(
                color: isSelected
                    ? widget.activeButtonColor
                    : widget.inactiveButtonColor,
                borderRadius: BorderRadius.circular(AppWidgetSize.dimen_20),
                border: widget.isBorder
                    ? Border.all(
                        color: widget.borderColor ??
                            Theme.of(context)
                                .snackBarTheme
                                .backgroundColor!
                                .withOpacity(0.5),
                        width: 1,
                      )
                    : null,
              ),
              child: CustomTextWidget(
                item,
                Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? widget.activeTextColor
                          : widget.inactiveTextColor,
                      fontSize: widget.fontSize.w,
                      fontWeight: FontWeight.w500,
                    ) ??
                    TextStyle(
                      color: isSelected
                          ? widget.activeTextColor
                          : widget.inactiveTextColor,
                      fontSize: widget.fontSize.w,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

