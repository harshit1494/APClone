import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImages {
  static Widget arihantNewLogoLight(
    BuildContext context, {
    double? width,
    double? height,
  }) {
    return SvgPicture.asset(
      'lib/assets/images/arihant_new_logo_light.svg',
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
      'lib/assets/images/arihant_new_logo_dark.svg',
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
      'lib/assets/images/google_logo.svg',
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
      'lib/assets/images/eye_open.svg',
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
      'lib/assets/images/eye_closed.svg',
      color: color,
      width: width,
      height: height,
    );
  }
}

