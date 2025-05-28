import 'package:deu_cis/product/constants/integer_consts.dart';
import 'package:flutter/material.dart';

@immutable
class PaddingConsts {
  PaddingConsts._();
  static const EdgeInsetsGeometry pageHorizontal =
      EdgeInsets.symmetric(horizontal: IntegerConsts.horizantalPadding);

  // static const EdgeInsetsGeometry menuItemsPadding =
  //     const EdgeInsets.fromLTRB(50, 5, 50, 5);

  // static const EdgeInsetsGeometry tabItemPadding =
  //     const EdgeInsets.fromLTRB(0, 0, 12, 0);
}
