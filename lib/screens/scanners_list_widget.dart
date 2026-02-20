import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/fandotag.dart';
import '../models/scanner_model.dart';
import '../models/symbols_model.dart';

class ScannersListWidget extends StatelessWidget {
  final List<Scanner>? scannerList;
  final List<Map<String, String>>? headerList;
  final ScrollController? scrollController;

  const ScannersListWidget({
    Key? key,
    this.scannerList,
    this.headerList,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scannerListLength = scannerList?.length ?? 0;
    final itemCount = scannerListLength > 0 ? scannerListLength + 1 : scannerListLength;

    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
      primary: false,
      shrinkWrap: true,
      controller: scrollController,
      itemCount: itemCount,
      itemBuilder: (BuildContext ctxt, int index) {
        if (index == itemCount - 1) {
          return const SizedBox.shrink();
        }
        return _buildRowWidget(context, scannerList![index], index);
      },
      padding: EdgeInsets.zero,
      separatorBuilder: (_, __) => Divider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 1,
        height: 1,
        indent: AppWidgetSize.dimen_16,
        endIndent: AppWidgetSize.dimen_16,
      ),
    );
  }

  Widget _buildRowWidget(BuildContext context, Scanner scannerItem, int index) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final chngValue = double.tryParse(scannerItem.chng?.replaceAll(',', '') ?? '0') ?? 0;
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
        padding: EdgeInsets.symmetric(
          horizontal: AppWidgetSize.dimen_16,
          vertical: AppWidgetSize.dimen_12,
        ),
        child: Row(
          children: [
            // Symbol name and exchange tag
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomTextWidget(
                                scannerItem.baseSym ?? scannerItem.dispSym ?? '--',
                                Theme.of(context)
                                    .primaryTextTheme
                                    .labelLarge!
                                    .copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.w,
                                    ),
                                textAlign: TextAlign.start,
                              ),
                              if (scannerItem.exc != null)
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: AppWidgetSize.dimen_8,
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: AppWidgetSize.dimen_2,
                                      horizontal: AppWidgetSize.dimen_4,
                                    ),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        AppWidgetSize.dimen_2,
                                      ),
                                      color: Theme.of(context)
                                          .inputDecorationTheme
                                          .fillColor,
                                    ),
                                    child: CustomTextWidget(
                                      scannerItem.exc!,
                                      Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.w600,
                                            fontSize: AppWidgetSize.dimen_8,
                                          ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      // Additional columns from headerList
                      if (headerList != null && headerList!.length > 1)
                        Padding(
                          padding: EdgeInsets.only(left: AppWidgetSize.dimen_8),
                          child: Container(
                            width: AppWidgetSize.dimen_80,
                            alignment: Alignment.topRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomTextWidget(
                                _getFormattedValue(
                                  scannerItem,
                                  headerList![1]['key'] ?? '',
                                ),
                                Theme.of(context)
                                    .primaryTextTheme
                                    .labelLarge!
                                    .copyWith(fontSize: 16.w),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ),
                      if (headerList != null && headerList!.length > 2)
                        Padding(
                          padding: EdgeInsets.only(left: AppWidgetSize.dimen_8),
                          child: Container(
                            width: AppWidgetSize.dimen_80,
                            alignment: Alignment.topRight,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CustomTextWidget(
                                _getFormattedValue(
                                  scannerItem,
                                  headerList![2]['key'] ?? '',
                                ),
                                Theme.of(context)
                                    .primaryTextTheme
                                    .labelLarge!
                                    .copyWith(fontSize: 16.w),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ),
                      SizedBox(width: AppWidgetSize.dimen_24),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: AppWidgetSize.dimen_8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomTextWidget(
                          scannerItem.ltp ?? '0.00',
                          Theme.of(context)
                              .primaryTextTheme
                              .labelSmall!
                              .copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.w,
                                color: color,
                              ),
                          isRupee: true,
                        ),
                        SizedBox(width: AppWidgetSize.dimen_4),
                        CustomTextWidget(
                          '${isPositive ? '+' : ''}${scannerItem.chngPer ?? '0.00'}%',
                          Theme.of(context)
                              .primaryTextTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context)
                                        .inputDecorationTheme
                                        .labelStyle
                                        ?.color ??
                                    Theme.of(context).textTheme.bodySmall?.color,
                              ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getFormattedValue(Scanner scannerItem, String key) {
    if (scannerItem.additionalData != null &&
        scannerItem.additionalData!.containsKey(key)) {
      return scannerItem.additionalData![key] ?? '--';
    }
    return '--';
  }
}

