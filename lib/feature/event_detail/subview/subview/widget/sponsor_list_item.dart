import 'package:deu_cis/product/constants/color_consts.dart';
import 'package:deu_cis/product/models/historys.dart';
import 'package:flutter/material.dart';

class SponsorListItem extends StatelessWidget {
  SponsorListItem({super.key, required this.sponsors, required this.index});

  final Sponsors sponsors;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.blueLight,
          child: Text(
            '${index + 1}',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        subtitle: Text(
          sponsors!.eventTitle ?? '',
        ),
        title: Text(
          sponsors!.sponsorTitle ?? '',
        ),
      ),
    );
  }
}
