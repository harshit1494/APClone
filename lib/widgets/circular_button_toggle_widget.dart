import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import 'custom_text_widget.dart';

class CircularButtonToggleWidget extends StatelessWidget {
  final String value;
  final List<String> toggleButtonlist;
  final Function(String) toggleButtonOnChanged;
  final EdgeInsets? marginEdgeInsets;
  final EdgeInsets? paddingEdgeInsets;
  final Color activeButtonColor;
  final Color activeTextColor;
  final Color inactiveButtonColor;
  final Color inactiveTextColor;
  final bool isBorder;
  final Color? borderColor;
  final double fontSize;
  final double spacing;

  const CircularButtonToggleWidget({
    Key? key,
    required this.value,
    required this.toggleButtonlist,
    required this.toggleButtonOnChanged,
    this.marginEdgeInsets,
    this.paddingEdgeInsets,
    required this.activeButtonColor,
    required this.activeTextColor,
    required this.inactiveButtonColor,
    required this.inactiveTextColor,
    this.isBorder = true,
    this.borderColor,
    this.fontSize = 15,
    this.spacing = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    
    return Wrap(
      spacing: spacing,
      runSpacing: 0,
      children: List.generate(toggleButtonlist.length, (int index) {
        final String item = toggleButtonlist[index];
        final bool isActive = value == item;

        return GestureDetector(
          onTap: () {
            toggleButtonOnChanged(item);
          },
          child: Container(
            margin: marginEdgeInsets ?? EdgeInsets.only(
              right: AppWidgetSize.dimen_1,
              top: AppWidgetSize.dimen_6,
            ),
            padding: paddingEdgeInsets ?? EdgeInsets.fromLTRB(
              AppWidgetSize.dimen_14,
              AppWidgetSize.dimen_6,
              AppWidgetSize.dimen_14,
              AppWidgetSize.dimen_6,
            ),
            decoration: BoxDecoration(
              color: isActive ? activeButtonColor : inactiveButtonColor,
              borderRadius: BorderRadius.circular(20.w),
              border: isBorder
                  ? Border.all(
                      color: borderColor ??
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
                    color: isActive ? activeTextColor : inactiveTextColor,
                    fontSize: fontSize.w,
                    fontWeight: FontWeight.w500,
                  ) ??
                  Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
        );
      }),
    );
  }
}

