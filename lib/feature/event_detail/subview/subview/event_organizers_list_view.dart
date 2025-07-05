import 'package:deu_cis/feature/event_detail/subview/subview/widget/event_institutions_list_item.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/vm/event_institution_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventOrganizersListView extends StatelessWidget {
  const EventOrganizersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppColors.greyLight,
      body: ChangeNotifierProvider.value(
          value: locator<EventInstitutionViewModel>(),
          child: Consumer<EventInstitutionViewModel>(
              builder: (context, eventInstitutionViewModel, child) {
            return ListView.builder(
              itemCount: eventInstitutionViewModel.eventOrganizers?.length ?? 0,
              itemBuilder: (context, index) {
                return EventInstitutionsListItem(
                  eventInstitution:
                      eventInstitutionViewModel.eventOrganizers![index],
                );
              },
            );
          })),
    );
  }
}
