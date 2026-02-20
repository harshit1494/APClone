import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static Widget arihantNewLogoLight(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/arihant_new_logo_light.svg',
      width: width,
      height: height,
    );
  }

  static Widget arihantNewLogoDark(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/arihant_new_logo_dark.svg',
      width: width,
      height: height,
    );
  }

  static Widget apNameLogoLight(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/ap_name_logo_light.svg',
      width: width,
      height: height,
    );
  }

  static Widget apNameLogoDark(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/ap_name_logo_dark.svg',
      width: width,
      height: height,
    );
  }

  static Widget googleLogo(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/google_logo.svg',
      width: width,
      height: height,
    );
  }

  static Widget eyeOpenIcon(
    BuildContext context, {
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/eye_open.svg',
      color: color,
      width: width,
      height: height,
    );
  }

  static Widget eyeClosedIcon(
    BuildContext context, {
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/eye_closed.svg',
      color: color,
      width: width,
      height: height,
    );
  }

  // Bottom Navigation Icons
  static Widget watchListDisable(
    BuildContext context, {
    bool isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/watchlist_disable.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget addFilledIcon(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/add.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget tradeDisable(
    BuildContext context, {
    bool isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/trade_disable1.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget tradeEnabled(
    BuildContext context, {
    bool isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/trade_enable.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget dashboardAcmlDisable(
    BuildContext context, {
    bool isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/dashboard_disabled.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget dashboardeEnabled(
    BuildContext context, {
    bool isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/dashboard_enabled.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget fundsDisable(
    BuildContext context, {
    bool isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/funds_disable1.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget fundsEnabled(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/funds_enable.svg',
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget exploreDisable(
    BuildContext context, {
    bool isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/explore_disable1.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget exploreEnabled(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/explore_enable.svg',
      color: (isColor == true) ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  // Watchlist Icons
  static Widget sortDisable(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/sort_disable.svg',
      color: isColor ? color : null,
      width: width ?? 25,
      height: height ?? 25,
    );
  }

  static Widget viewWatchlistIcon(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/view_watchlist.svg',
      color: isColor ? color : null,
      width: width ?? 25,
      height: height ?? 25,
    );
  }

  static Widget infoIcon(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/info_icon.svg',
      color: isColor ? color : null,
      width: width ?? 20,
      height: height ?? 20,
    );
  }

  static Widget holdingsIcon(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/holdings_icon.svg',
      color: isColor ? color : null,
      width: width ?? 22,
      height: height ?? 22,
    );
  }

  static Widget globeIcon(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/globe.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget researchLogo(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/research_logo.svg',
      color: isColor ? color : null,
      width: width ?? 26,
      height: height ?? 26,
    );
  }

  static Widget marketsPullDown(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/assetIcon.svg',
      color: isColor ? color : null,
      width: width ?? 25,
      height: height ?? 25,
    );
  }

  static Widget downArrow(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/down_arrow.svg',
      color: isColor ? color : null,
      width: width ?? 25,
      height: height ?? 25,
    );
  }

  static Widget closeIcon(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/close_icon.svg',
      color: isColor ? color : null,
      width: width ?? 25,
      height: height ?? 25,
    );
  }

  static Widget greenTickIcon(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/green_tick.svg',
      width: width ?? 22,
      height: height ?? 22,
    );
  }

  static Widget scannersFilterIcon(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/sliders.svg',
      color: isColor == true ? color : null,
      width: width ?? 24,
      height: height ?? 24,
    );
  }

  static Widget sortUp(
    BuildContext context, {
    bool? isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/sort_up.svg',
      color: isColor == true ? color : null,
      width: width ?? 12,
      height: height ?? 12,
    );
  }

  static Widget sortDown(
    BuildContext context, {
    bool? isColor = false,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      'assets/images/sort_down.svg',
      color: isColor == true ? color : null,
      width: width ?? 12,
      height: height ?? 12,
    );
  }

  // Orders Screen Icons
  static Widget tradeHistory(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return Icon(
      Icons.history,
      color: Theme.of(context).primaryIconTheme.color,
      size: width ?? 15,
    );
  }

  static Widget ordersSettings(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return Icon(
      Icons.settings,
      color: color ?? Theme.of(context).primaryIconTheme.color,
      size: width ?? 24,
    );
  }

  static Widget informationIcon(
    BuildContext context, {
    bool isColor = false,
    Color? color,
    double? width,
    double? height,
  }) {
    return Icon(
      Icons.info_outline,
      color: color ?? Theme.of(context).primaryIconTheme.color,
      size: width ?? 30,
    );
  }

  static Widget closeCross(
    BuildContext context, {
    bool? isColor,
    Color? color,
    double? width,
    double? height,
  }) {
    return Icon(
      Icons.close,
      color: color ?? Theme.of(context).primaryColor,
      size: width ?? 15,
    );
  }

  static Widget deleteIcon(
    BuildContext context, {
    Color? color,
    double? width,
    double? height,
  }) {
    return Icon(
      Icons.close,
      color: color ?? Theme.of(context).primaryIconTheme.color,
      size: width ?? 25,
    );
  }

  static Widget searchIcon(
    BuildContext context, {
    bool? isColor,
    Color? color,
    double? width,
    double? height,
  }) {
    return Icon(
      Icons.search,
      color: color ?? Theme.of(context).primaryIconTheme.color,
      size: width ?? 24,
    );
  }

  static Widget filterIcon(
    BuildContext context, {
    bool? isColor,
    Color? color,
    double? width,
    double? height,
  }) {
    return Icon(
      Icons.filter_list,
      color: color ?? Theme.of(context).primaryIconTheme.color,
      size: width ?? 24,
    );
  }

  // Product Icons
  static Widget productCash(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_cash.svg',
      width: width,
      height: height,
    );
  }

  static Widget productFO(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_fno.svg',
      width: width,
      height: height,
    );
  }

  static Widget productETF(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_etf.svg',
      width: width,
      height: height,
    );
  }

  static Widget productCommodity(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_commodity.svg',
      width: width,
      height: height,
    );
  }

  static Widget productCurrency(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_currency.svg',
      width: width,
      height: height,
    );
  }

  static Widget productIpo(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_ipo.svg',
      width: width,
      height: height,
    );
  }

  static Widget productNCD(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_ncd.svg',
      width: width,
      height: height,
    );
  }

  static Widget productMFOverview(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/product_mfOverview.svg',
      width: width,
      height: height,
    );
  }

  static Widget heartIcon(
    BuildContext context, {
    Color? color,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/heart.svg',
      width: width,
      height: height,
      color: color,
    );
  }

  static AssetImage goldEtf() {
    return const AssetImage('assets/images/gold_etf.png');
  }

  static AssetImage silverEtf() {
    return const AssetImage('assets/images/silver_etf.png');
  }

  static AssetImage indexEtf() {
    return const AssetImage('assets/images/index_etf.png');
  }

  static AssetImage debtEtf() {
    return const AssetImage('assets/images/debt_etf.png');
  }

  static AssetImage globalEtf() {
    return const AssetImage('assets/images/global_etf.png');
  }

  static AssetImage othersEtf() {
    return const AssetImage('assets/images/others_etf.png');
  }

  static AssetImage fundsCoin() {
    return const AssetImage('assets/images/funds_coin.png');
  }

  static Widget funddetails(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SvgPicture.asset(
      isLight
          ? 'assets/images/fund_details.svg'
          : 'assets/images/fund_details_dark.svg',
      width: width,
      height: height,
    );
  }

  static Widget fundhistory(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SvgPicture.asset(
      isLight
          ? 'assets/images/fund_history.svg'
          : 'assets/images/fund_history_dark.svg',
      width: width,
      height: height,
    );
  }

  static Widget pledgeCoinImage(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SvgPicture.asset(
      isLight ? 'assets/images/pledge_coin.svg' : 'assets/images/pledge_coin_dark.svg',
      width: width,
      height: height,
    );
  }

  static Widget ipo(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    return SvgPicture.asset(
      isLight ? 'assets/images/ipo.svg' : 'assets/images/ipo_dark.svg',
      width: width,
      height: height,
    );
  }

  static Widget smeTag(
    BuildContext context, {
    bool? isColor,
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'assets/images/sme.svg',
      width: width,
      height: height,
    );
  }

  static AssetImage candleChartImg() {
    return const AssetImage('assets/images/candle_chart_bg.png');
  }

  static AssetImage discoverSip() {
    return const AssetImage('assets/images/discover_sip.png');
  }

  static AssetImage discoverScanners() {
    return const AssetImage('assets/images/discover_scanner.png');
  }

  static AssetImage discoverNcd() {
    return const AssetImage('assets/images/discover_ncd.png');
  }

  static AssetImage discoverfiidii() {
    return const AssetImage('assets/images/discover_fiidii.png');
  }

  static AssetImage discoverSupport() {
    return const AssetImage('assets/images/discover_support.png');
  }

  static AssetImage discoverGtd() {
    return const AssetImage('assets/images/discover_gtd.png');
  }

  static AssetImage discoverResearch() {
    return const AssetImage('assets/images/discover_research.png');
  }

  static AssetImage discoverBasket() {
    return const AssetImage('assets/images/discover_basket.png');
  }

  static AssetImage discoverReports() {
    return const AssetImage('assets/images/discover_reports.png');
  }

  static AssetImage referAndEarnBannerImg() {
    return const AssetImage('assets/images/refer_earn_banner_img.png');
  }

  static AssetImage cmsSip() {
    return const AssetImage('assets/images/cms_sip.png');
  }

  static AssetImage manageDash() {
    return const AssetImage('assets/images/manage_dash.png');
  }

  static AssetImage feedbackBannerImg() {
    return const AssetImage('assets/images/feedback_banner.png');
  }

  static AssetImage feedbackStar() {
    return const AssetImage('assets/images/feedback_star.png');
  }
}

