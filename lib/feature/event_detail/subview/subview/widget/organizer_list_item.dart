import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/historys.dart';
import 'package:flutter/material.dart';

class OrganizerListItem extends StatelessWidget {
  OrganizerListItem({
    super.key,
    required this.organizers,
    required this.index,
  });

  final Organizers organizers;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: ListTile(
        title: Text(
          organizers!.eventTitle ?? '',
        ),
        leading: CircleAvatar(
          backgroundColor: AppColors.blueLight,
          child: Text(
            '${index + 1}',
            style: TextStyle(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
