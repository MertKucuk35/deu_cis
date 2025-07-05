import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/material.dart';

class TitleItem extends StatelessWidget {
  const TitleItem({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.titleTextBlack,
      ),
    );
  }
}

class TitleItemSmall extends StatelessWidget {
  const TitleItemSmall({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: AppTextStyles.textFieldTextBoldGrey,
      ),
    );
  }
}
