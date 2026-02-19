import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';

Widget gradientButtonWidget({
  required Function onTap,
  required double width,
  required Key key,
  required BuildContext context,
  required String title,
  required bool isGradient,
  double bottom = 40,
  double? height,
  double? fontsize,
  FontWeight? fontWeight,
}) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  final gradientColors = [
    Theme.of(context).colorScheme.onSurface,
    Theme.of(context).primaryColor,
  ];
  
  return IgnorePointer(
    ignoring: false,
    child: GestureDetector(
      onTap: () => onTap(),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottom),
        child: Container(
          key: key,
          alignment: Alignment.center,
          width: width,
          height: height ?? AppWidgetSize.dimen_54,
          decoration: isGradient
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(AppWidgetSize.dimen_30),
                  gradient: LinearGradient(
                    stops: const [0.0, 1.0],
                    begin: Alignment.topLeft,
                    end: Alignment.topRight,
                    colors: gradientColors,
                  ),
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.circular(AppWidgetSize.dimen_30),
                ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Colors.white,
              fontWeight: fontWeight ?? FontWeight.w400,
              fontSize: fontsize,
            ),
          ),
        ),
      ),
    ),
  );
}
