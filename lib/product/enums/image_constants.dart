import 'package:deu_cis/product/constants/string_consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum ImageConstants {
  appLogo('ybs_logo.png'),
  demoBg('abb_bg.png'),
  demoLogo('abb_logo.png');

  final String value;
  const ImageConstants(this.value);

  String get toPng => 'assets/images/$value';
  Image get toImage => Image.asset(toPng);
}

enum SVGConstants {
  calenderAdd('calender_add.svg'),
  calenderAdded('calender_added.svg');

  final String value;

  const SVGConstants(this.value);

  String get toPath => 'assets/images/$value';
  SvgPicture get toSVG => SvgPicture.asset(
        toPath,
        height: 26,
        width: 26,
      );
}
