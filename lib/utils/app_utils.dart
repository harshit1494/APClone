import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_widget_size.dart';
import 'app_images.dart';

class AppUtils {
  Widget buildFilterIcon(BuildContext context, {bool isSelected = false}) {
    return SizedBox(
      width: AppWidgetSize.dimen_30,
      height: AppWidgetSize.dimen_22,
      child: Stack(
        children: [
          AppImages.sortDisable(
            context,
            color: Theme.of(context).primaryIconTheme.color,
            isColor: true,
            height: 25.w,
            width: 25.w,
          ),
          isSelected
              ? Positioned(
                  right: 7.w,
                  child: Container(
                    width: AppWidgetSize.dimen_5,
                    height: AppWidgetSize.dimen_5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.w),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}

