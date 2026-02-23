import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_images.dart';
import 'custom_text_widget.dart';

class FeedbackBannerWidget extends StatelessWidget {
  const FeedbackBannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppWidgetSize.dimen_30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.w),
              border: Border.all(
                width: 1.w,
                color: Theme.of(context).dividerColor,
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  const Color(0xFFBA68C8).withOpacity(0.08),
                ],
              ),
            ),
            child: InkWell(
              onTap: () {
                // Navigate to feedback screen
                // For now, just show a placeholder
              },
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextWidget(
                          'Enjoying the App?',
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontSize: AppWidgetSize.fontSize16,
                              ) ??
                              TextStyle(
                                fontSize: AppWidgetSize.fontSize16,
                              ),
                        ),
                        CustomTextWidget(
                          'Rate your experience with us',
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 14.w,
                                color: Theme.of(context)
                                    .inputDecorationTheme
                                    .labelStyle
                                    ?.color,
                              ) ??
                              TextStyle(
                                fontSize: 14.w,
                              ),
                          textAlign: TextAlign.start,
                          padding: EdgeInsets.symmetric(vertical: 6.w),
                          maxLines: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(5, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 2,
                                vertical: 3,
                              ),
                              child: Image(
                                image: AppImages.feedbackStar(),
                                height: 18.w,
                                width: 18.w,
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30.w),
                  Image(
                    image: AppImages.feedbackBannerImg(),
                    height: 74.w,
                    width: 74.w,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

