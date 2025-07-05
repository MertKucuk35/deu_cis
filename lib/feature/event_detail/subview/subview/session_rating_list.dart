import 'package:deu_cis/feature/event_detail/subview/subview/session_rating_view.dart';
import 'package:deu_cis/feature/event_detail/subview/subview/widget/session_rating_lsit_item.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/product/vm/event_agenda_view_model.dart';
import 'package:flutter/material.dart';

class SessionRatingList extends StatelessWidget {
  const SessionRatingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.greyLight,
      body: ListView.builder(
        itemCount:
            locator<EventAgendaViewModel>().addedAgendaSessions?.length ?? 0,
        itemBuilder: (context, index) {
          return SessionRatingListItem(
            index: index,
            function: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SessionRatingView(
                  sessionID: locator<EventAgendaViewModel>()
                      .addedAgendaSessions![index]
                      .id!,
                  userID: locator<AuthViewModel>().user!.id,
                ),
              ));
            },
            eventSession:
                locator<EventAgendaViewModel>().addedAgendaSessions![index]!,
          );
        },
      ),
    );
  }
}
