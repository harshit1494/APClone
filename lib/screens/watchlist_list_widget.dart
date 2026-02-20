import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/fandotag.dart';
import '../models/symbols_model.dart';

class WatchlistListWidget extends StatelessWidget {
  final List<Symbols>? symbolList;
  final ScrollController? scrollController;
  final bool isFromWatchlistScreen;

  const WatchlistListWidget({
    Key? key,
    this.symbolList,
    this.scrollController,
    this.isFromWatchlistScreen = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OnlyOnePointerRecognizerWidget(
      child: isFromWatchlistScreen
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: buildStockListWidget(context),
                ),
              ],
            )
          : SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              child: Column(
                children: [
                  buildStockListWidget(context),
                ],
              ),
            ),
    );
  }

  ListView buildStockListWidget(BuildContext context) {
    final symbolListLength = symbolList?.length ?? 0;
    final itemCount = symbolListLength > 0 ? symbolListLength + 1 : symbolListLength;
    
    return ListView.separated(
      physics: isFromWatchlistScreen
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(), // Disable scrolling when inside parent scroll
      primary: false,
      shrinkWrap: true,
      cacheExtent: 20,
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: (BuildContext ctxt, int index) {
        if (index == itemCount - 1) {
          return const SizedBox.shrink();
        }
        return _buildRowWidget(context, symbolList![index], index);
      },
      padding: EdgeInsets.zero, // Remove bottom padding to prevent extra scroll
      separatorBuilder: (_, __) => Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 0.5,
        indent: 25.w,
        endIndent: 25.w,
        height: 0,
      ),
    );
  }

  Widget _buildRowWidget(BuildContext context, Symbols symbolItem, int index) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final chngValue = double.tryParse(symbolItem.chng ?? '0') ?? 0;
    final isPositive = chngValue >= 0;
    final color = isPositive
        ? AppColors.positiveColor(isLight)
        : AppColors.negativeColor;

    return GestureDetector(
      onTap: () {
        // Navigate to stock details
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        margin: EdgeInsets.symmetric(horizontal: 25.w),
        child: Container(
          width: AppWidgetSize.screenWidth(context),
            padding: EdgeInsets.symmetric(
              vertical: AppWidgetSize.dimen_16,
            ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppWidgetSize.dimen_10),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomTextWidget(
                      symbolItem.dispSym ?? '',
                      Theme.of(context)
                          .primaryTextTheme
                          .labelSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  CustomTextWidget(
                    symbolItem.ltp ?? '0',
                    Theme.of(context).primaryTextTheme.labelLarge!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: color,
                        ),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
              SizedBox(height: AppWidgetSize.dimen_2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: CustomTextWidget(
                            symbolItem.companyName?.toUpperCase() ?? '',
                            Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                                  fontSize: 12.w,
                                  color: Theme.of(context)
                                          .inputDecorationTheme
                                          .labelStyle
                                          ?.color ??
                                      Theme.of(context).textTheme.bodySmall?.color ??
                                      (isLight ? AppColors.appTextColorSecondary : AppColors.appTextColorSecondaryDark),
                                ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        // NSE tag next to company name (small)
                        if (symbolItem.exc == 'NSE' || symbolItem.exc == 'BSE')
                          Padding(
                            padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
                            child: FandOTag(
                              symbolItem,
                              showExpiry: false,
                              showWeekly: false,
                              removeLeftPadding: true,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: CustomTextWidget(
                        '${isPositive ? '+' : ''}${symbolItem.chngPer ?? '0'}%',
                        Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                              color: Theme.of(context)
                                      .inputDecorationTheme
                                      .labelStyle
                                      ?.color ??
                                  Theme.of(context).textTheme.bodySmall?.color ??
                                  (isLight ? AppColors.appTextColorSecondary : AppColors.appTextColorSecondaryDark),
                            ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  WidgetSpan _buildHoldingsWidgetSpan(BuildContext context) {
    return WidgetSpan(
      alignment: ui.PlaceholderAlignment.middle,
      child: Padding(
        padding: EdgeInsets.only(left: AppWidgetSize.dimen_5),
        child: Container(
          padding: EdgeInsets.only(
            left: AppWidgetSize.dimen_3,
            right: AppWidgetSize.dimen_3,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppWidgetSize.dimen_15),
            color: AppColors.positiveColor(
              Theme.of(context).brightness == Brightness.light,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(AppWidgetSize.dimen_2),
            child: FittedBox(
              child: Text(
                'H',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontSize: 9.w,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getQtyWidget(BuildContext context, String qty) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return Align(
      alignment: Alignment.centerLeft,
      child: CustomTextWidget(
        '$qty qty',
        Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
              fontSize: 12.w,
              color: Theme.of(context).inputDecorationTheme.labelStyle?.color ??
                  Theme.of(context).textTheme.bodySmall?.color ??
                  (isLight ? AppColors.appTextColorSecondary : AppColors.appTextColorSecondaryDark),
            ),
        padding: EdgeInsets.only(top: AppWidgetSize.dimen_4),
        textAlign: TextAlign.left,
      ),
    );
  }
}

// Placeholder widget for single pointer recognition
class OnlyOnePointerRecognizerWidget extends StatelessWidget {
  final Widget child;

  const OnlyOnePointerRecognizerWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

