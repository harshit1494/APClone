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
  bool isErrorButton = false,
  bool isLoading = false,
  Widget? icon,
  double? height,
  Color? backgroundcolor,
  Color? borderColor,
  Color? inactiveTextColor,
  double bottom = 40,
  double? fontsize,
  FontWeight? fontWeight,
  double? borderWidth,
  List<Color>? gradientColors,
  bool? isDisbleBtn = false,
  bool? isBold = false,
}) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  gradientColors = gradientColors ??
      [
        isDisbleBtn == true
            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.3)
            : Theme.of(context).colorScheme.onSurface,
        isDisbleBtn == true
            ? Theme.of(context).primaryColor.withOpacity(0.3)
            : Theme.of(context).primaryColor,
      ];
  
  return IgnorePointer(
    ignoring: isDisbleBtn == true || isLoading == true,
    child: GestureDetector(
      onTap: () {
        if (isDisbleBtn == true || isLoading == true) return;
        onTap();
      },
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
                    colors: gradientColors!,
                  ),
                )
              : BoxDecoration(
                  border: Border.all(
                    color: isErrorButton
                        ? isDisbleBtn == true
                            ? AppColors.negativeColor.withOpacity(0.3)
                            : AppColors.negativeColor
                        : isDisbleBtn == true
                            ? (borderColor ?? AppColors.positiveColor(isLight))
                                .withOpacity(0.3)
                            : (borderColor ?? AppColors.positiveColor(isLight)),
                    width: borderWidth ?? 1.5,
                  ),
                  color: backgroundcolor,
                  borderRadius: BorderRadius.circular(AppWidgetSize.dimen_30),
                ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isLoading
                ? SizedBox(
                    height: AppWidgetSize.dimen_22,
                    width: AppWidgetSize.dimen_22,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) icon,
                      Text(
                        title,
                        style: isGradient
                            ? Theme.of(context).textTheme.displaySmall!.copyWith(
                                  color: Colors.white,
                                  fontWeight: fontWeight ?? FontWeight.w400,
                                  fontSize: fontsize,
                                )
                            : Theme.of(context)
                                .primaryTextTheme
                                .displaySmall!
                                .copyWith(
                                  fontWeight: fontWeight ?? FontWeight.w400,
                                  fontSize: fontsize,
                                    color: isErrorButton
                                        ? isDisbleBtn == true
                                            ? AppColors.negativeColor
                                                .withOpacity(0.3)
                                            : AppColors.negativeColor
                                        : isDisbleBtn == true
                                            ? (inactiveTextColor ??
                                                    AppColors.positiveColor(isLight))
                                                .withOpacity(0.3)
                                            : (inactiveTextColor ??
                                                AppColors.positiveColor(isLight)),
                                ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ),
  );
}
