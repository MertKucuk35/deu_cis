import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:flutter/material.dart';

class SessionRatingListItem extends StatelessWidget {
  SessionRatingListItem(
      {super.key,
      required this.eventSession,
      required this.function,
      required this.index});

  EventSession eventSession;
  VoidCallback? function;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: AppColors.white,
      child: ListTile(
        onTap: function,
        leading: CircleAvatar(
          backgroundColor: AppColors.blueLight,
          child: Text(
            '${index + 1}',
            style: TextStyle(color: AppColors.white),
          ),
        ),
        title: Text(eventSession.title ?? 'No Title'),
      ),
    );
  }
}
