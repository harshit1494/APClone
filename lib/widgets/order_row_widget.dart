import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_widget_size.dart';
import '../utils/app_color.dart';
import '../widgets/custom_text_widget.dart';
import '../widgets/fandotag.dart';
import '../widgets/label_border_text_widget.dart';
import '../widgets/rupee_symbol_widget.dart';
import '../models/order_model.dart';
import '../models/symbols_model.dart';

class OrderRowWidget extends StatelessWidget {
  final Order order;
  final Function(Order) onRowClick;
  final bool isLastIndex;

  const OrderRowWidget({
    Key? key,
    required this.order,
    required this.onRowClick,
    this.isLastIndex = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onRowClick(order);
      },
      child: Container(
        decoration: !isLastIndex
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: AppWidgetSize.dimen_1,
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                color: Theme.of(context).scaffoldBackgroundColor,
              )
            : null,
        width: AppWidgetSize.fullWidth(context) - 10,
        padding: EdgeInsets.only(
          top: AppWidgetSize.dimen_10,
          bottom: AppWidgetSize.dimen_10,
          left: AppWidgetSize.dimen_24,
          right: AppWidgetSize.dimen_24,
        ),
        child: _buildRowContentWidget(context),
      ),
    );
  }

  Widget _buildRowContentWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTopRowWidget(context),
        _buildMiddleRowWidget(context),
        _buildBottomRowWidget(context),
      ],
    );
  }

  Widget _buildTopRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            _buildDispSymAndExcWidget(context),
          ],
        ),
        _buildPrdTypeWidget(context),
      ],
    );
  }

  Widget _buildDispSymAndExcWidget(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    Color backGroundColor = isLight
        ? const Color(0xFFF2F2F2)
        : const Color(0xFF282F35);
    Color textColor = isLight
        ? const Color(0xFF797979)
        : const Color(0xFFFFFFFF);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
            top: AppWidgetSize.dimen_6,
          ),
          child: CustomTextWidget(
            order.dispSym ?? order.sym ?? '--',
            Theme.of(context)
                .primaryTextTheme
                .labelSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (order.exc != null)
          FandOTag(
            Symbols(exc: order.exc),
            showTag: true,
          ),
      ],
    );
  }

  Widget _buildPrdTypeWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_10,
      ),
      child: order.ordType == null
          ? Container()
          : order.ordType!.toUpperCase() == 'MARKET'
              ? _getLableWithRupeeSymbol(
                  context,
                  order.avgPrice ?? "0.00",
                  Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                  Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                )
              : _getLableWithRupeeSymbol(
                  context,
                  order.limitPrice ?? "-",
                  Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
                        fontSize: 16.w,
                        fontWeight: FontWeight.w500,
                      ),
                  Theme.of(context).primaryTextTheme.labelSmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.w,
                      ),
                ),
    );
  }

  Widget _buildMiddleRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOrdTypeAndOrdStatusWidget(context),
        _buildOrdActionAndQtyWidget(context),
      ],
    );
  }

  Widget _buildOrdTypeAndOrdStatusWidget(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxWidth: AppWidgetSize.screenWidth(context) * 0.52),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            _statusField2(context, order.prdType ?? '', 'none', false),
            _statusField2(context, _capitalizeFirst(order.ordType ?? ''), 'none', true),
            _statusField2(context, _capitalizeFirst(order.status ?? ''), order.status ?? '', false),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdActionAndQtyWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(
              right: AppWidgetSize.dimen_8,
            ),
            child: CustomTextWidget(
              _capitalizeFirst(order.ordAction ?? ''),
              _purchaseSellStyle(context, order.ordAction ?? ''),
            ),
          ),
          SizedBox(
            height: AppWidgetSize.dimen_20,
            width: AppWidgetSize.dimen_70,
            child: FittedBox(
              alignment: Alignment.centerRight,
              fit: BoxFit.scaleDown,
              child: CustomTextWidget(
                '${order.tradedQty ?? '0'}/${order.qty ?? '0'} Qty',
                Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomRowWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOrdDateAndAmoWidget(context),
        _buildLtpWidget(context),
      ],
    );
  }

  Widget _buildOrdDateAndAmoWidget(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: AppWidgetSize.dimen_10,
            left: AppWidgetSize.dimen_1,
          ),
          child: CustomTextWidget(
            order.ordDate ?? '--',
            Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        if (order.isAmo ?? false)
          Padding(
            padding: EdgeInsets.only(
              left: AppWidgetSize.dimen_5,
            ),
            child: _statusField(context, 'AMO', 'none'),
          ),
      ],
    );
  }

  Widget _buildLtpWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_10,
      ),
      child: CustomTextWidget(
        order.ltp == null
            ? ""
            : 'LTP ${order.ltp}',
        Theme.of(context).primaryTextTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }

  Widget _getLableWithRupeeSymbol(
    BuildContext context,
    String value,
    TextStyle rupeeStyle,
    TextStyle textStyle,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Rupee symbol with Arial font (web-safe and supports rupee)
        Text(
          '₹',
          style: TextStyle(
            fontSize: rupeeStyle.fontSize,
            fontWeight: rupeeStyle.fontWeight,
            color: rupeeStyle.color,
            fontFamily: 'Arial', // Arial supports rupee symbol on web
          ),
        ),
        SizedBox(width: 2.w),
        CustomTextWidget(
          value,
          textStyle,
        ),
      ],
    );
  }

  Padding _statusField(BuildContext context, String label, String type) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_8,
        right: AppWidgetSize.dimen_5,
      ),
      child: _getLabelBorderWidget(
        context,
        label,
        type,
      ),
    );
  }

  Padding _statusField2(BuildContext context, String label, String type, bool isUpper) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppWidgetSize.dimen_8,
        right: AppWidgetSize.dimen_5,
      ),
      child: _getLabelBorderWidget2(
        context,
        label,
        type,
        isUpper,
      ),
    );
  }

  Widget _getLabelBorderWidget2(
    BuildContext context,
    String title,
    String status,
    bool isUpper,
  ) {
    return SizedBox(
      width: title.length * 8.0 + 10.w,
      child: LabelBorderWidget(
        text: title,
        textColor: _statusTextColor(context, status),
        fontSize: AppWidgetSize.fontSize10,
        borderRadius: AppWidgetSize.dimen_20,
        padding: EdgeInsets.all(4.w),
        margin: EdgeInsets.only(right: AppWidgetSize.dimen_1),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        borderWidth: 1.w,
        borderColor: _statusBorderColor(context, status),
        showNSETag: true,
      ),
    );
  }

  Widget _getLabelBorderWidget(
    BuildContext context,
    String title,
    String status,
  ) {
    return SizedBox(
      width: title.length * 8.0 + AppWidgetSize.dimen_10,
      child: LabelBorderWidget(
        text: title,
        textColor: _statusTextColor(context, status),
        fontSize: AppWidgetSize.fontSize12,
        borderRadius: AppWidgetSize.dimen_20,
        margin: EdgeInsets.only(right: AppWidgetSize.dimen_1),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        borderWidth: 1,
        borderColor: _statusBorderColor(context, status),
        showNSETag: true,
      ),
    );
  }

  Color _statusTextColor(BuildContext context, String status) {
    if (status.toLowerCase() == 'none') {
      return Theme.of(context).inputDecorationTheme.labelStyle?.color ??
          Theme.of(context).textTheme.bodySmall?.color ??
          Colors.grey;
    } else if (status.toLowerCase() == 'executed') {
      return AppColors.positiveColor(Theme.of(context).brightness == Brightness.light);
    } else if (status.toLowerCase() == 'pending') {
      return Theme.of(context).indicatorColor;
    } else {
      return AppColors.negativeColor;
    }
  }

  Color _statusBorderColor(BuildContext context, String status) {
    if (status.toLowerCase() == 'none') {
      return Theme.of(context).dividerColor;
    } else if (status.toLowerCase() == 'executed') {
      return AppColors.positiveColor(Theme.of(context).brightness == Brightness.light);
    } else if (status.toLowerCase() == 'pending') {
      return Theme.of(context).indicatorColor;
    } else {
      return AppColors.negativeColor;
    }
  }

  TextStyle _purchaseSellStyle(BuildContext context, String orderAction) {
    return orderAction.toLowerCase() == 'buy'
        ? Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.positiveColor(Theme.of(context).brightness == Brightness.light))
        : Theme.of(context).primaryTextTheme.bodySmall!.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.negativeColor);
  }

  String _capitalizeFirst(String str) {
    if (str.isEmpty) return str;
    return str[0].toUpperCase() + str.substring(1).toLowerCase();
  }
}

