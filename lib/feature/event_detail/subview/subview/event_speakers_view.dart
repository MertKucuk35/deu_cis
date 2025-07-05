import 'package:deu_cis/feature/public_profile/profile_detail_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/event_attende_list_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/vm/event_attendes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventSpeakersView extends StatelessWidget {
  const EventSpeakersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        StringConsts.infBtnSpeakers,
        style: TextStyle(color: AppColors.white),
      )),
      body: ChangeNotifierProvider.value(
          value: locator<EventAttendesViewModel>(),
          child: Consumer<EventAttendesViewModel>(
              builder: (context, eventAttendesViewModel, child) {
            return ListView.builder(
              itemCount: eventAttendesViewModel.speakers?.length ?? 0,
              itemBuilder: (context, index) {
                return EventAttendeListItem(
                  eventAttende: eventAttendesViewModel.speakers![index],
                  function: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return ProfileDetailView(
                          profileID:
                              eventAttendesViewModel.speakers![index].userId!,
                        );
                      },
                    ));
                  },
                );
              },
            );
          })),
    );
  }
}
