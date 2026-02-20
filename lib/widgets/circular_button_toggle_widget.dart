import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import 'custom_text_widget.dart';

class CircularButtonToggleWidget extends StatelessWidget {
  final String value;
  final List<String>? buttonNoList;
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
    this.buttonNoList,
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
            child: buttonNoList == null
                ? CustomTextWidget(
                    item,
                    Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isActive ? activeTextColor : inactiveTextColor,
                          fontSize: fontSize.w,
                          fontWeight: FontWeight.w500,
                        ) ??
                        Theme.of(context).textTheme.bodyMedium!,
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextWidget(
                        item,
                        Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isActive ? activeTextColor : inactiveTextColor,
                              fontSize: fontSize.w,
                              fontWeight: FontWeight.w500,
                            ) ??
                            Theme.of(context).textTheme.bodyMedium!,
                      ),
                      if (index < buttonNoList!.length)
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Container(
                            alignment: Alignment.center,
                            height: 16.w,
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.1),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100.w),
                              color: isActive
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).dividerColor,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w, right: 5.w),
                              child: CustomTextWidget(
                                buttonNoList![index],
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: isActive
                                          ? Colors.white
                                          : Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .color,
                                      fontSize: 12.w,
                                    ) ??
                                    Theme.of(context).textTheme.bodyMedium!,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
        );
      }),
    );
  }
}

