import 'package:flutter/material.dart';
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
}

