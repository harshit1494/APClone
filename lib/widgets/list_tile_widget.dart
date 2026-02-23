import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import 'custom_text_widget.dart';

class ListTileWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool showArrow;
  final Widget? leadingImage;
  final Widget? tagWidget;
  final Widget? otherWidget;
  final TextStyle? titleTextStyle;
  final TextStyle? subtitleTextStyle;
  final String? otherTitle;
  final bool isBackgroundOther;
  final bool showIndent;
  final bool hideDivider;
  final void Function()? onTap;

  const ListTileWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.titleTextStyle,
    this.showArrow = true,
    this.onTap,
    this.leadingImage,
    this.otherTitle,
    this.otherWidget,
    this.isBackgroundOther = false,
    this.showIndent = false,
    this.hideDivider = false,
    this.tagWidget,
    this.subtitleTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          overlayColor: WidgetStateProperty.all<Color>(
            (Theme.of(context).dialogTheme.backgroundColor ?? 
             Theme.of(context).scaffoldBackgroundColor).withOpacity(0.1),
          ),
          onTap: () {
            if (onTap != null) onTap!();
          },
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 9.w,
              vertical: 0.w,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ListTile(
                  horizontalTitleGap: 5.w,
                  contentPadding: EdgeInsets.all(AppWidgetSize.dimen_1),
                  leading: leadingImage != null
                      ? Padding(
                          padding: EdgeInsets.zero,
                          child: leadingImage,
                        )
                      : null,
                  subtitle: subtitle == ''
                      ? null
                      : CustomTextWidget(
                          subtitle,
                          subtitleTextStyle ??
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    fontSize: AppWidgetSize.fontSize12,
                                  ),
                        ),
                  title: Padding(
                    padding: EdgeInsets.zero,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: otherWidget != null
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: CustomTextWidget(
                            title,
                            titleTextStyle ??
                                Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.start,
                          ),
                        ),
                        if (tagWidget != null) tagWidget!,
                        if (otherWidget != null && otherTitle == null)
                          Padding(
                            padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
                            child: otherWidget!,
                          ),
                        if (otherTitle != null)
                          Flexible(
                            child: Container(
                              decoration: isBackgroundOther
                                  ? BoxDecoration(
                                      color: Theme.of(context)
                                          .snackBarTheme
                                          .backgroundColor ??
                                          Theme.of(context).scaffoldBackgroundColor,
                                      borderRadius: BorderRadius.circular(
                                        AppWidgetSize.dimen_20,
                                      ),
                                    )
                                  : null,
                              padding: EdgeInsets.symmetric(
                                vertical: AppWidgetSize.dimen_2,
                                horizontal: AppWidgetSize.dimen_10,
                              ),
                              alignment: Alignment.center,
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.center,
                                child: CustomTextWidget(
                                  otherTitle ?? "",
                                  Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        fontSize: AppWidgetSize.fontSize14,
                                        color: AppColors.positiveColor(
                                          Theme.of(context).brightness ==
                                              Brightness.light,
                                        ),
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (showArrow)
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).textTheme.displayLarge?.color ??
                                 Theme.of(context).primaryIconTheme.color,
                          size: 16.w,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!hideDivider)
          Divider(
            indent: showIndent ? AppWidgetSize.dimen_16 : 0,
            endIndent: showIndent ? AppWidgetSize.dimen_16 : 0,
            height: 1,
            thickness: 1.w,
            color: Theme.of(context).dividerColor,
          ),
      ],
    );
  }
}

