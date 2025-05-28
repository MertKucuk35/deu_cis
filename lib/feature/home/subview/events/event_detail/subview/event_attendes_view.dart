import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/event_attende_list_item.dart';
import 'package:deu_cis/product/vm/event_attendes_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventAttendesView extends StatefulWidget {
  const EventAttendesView({super.key});

  @override
  State<EventAttendesView> createState() => _EventAttendesViewState();
}

class _EventAttendesViewState extends State<EventAttendesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider.value(
          value: locator<EventAttendesViewModel>(),
          child: Consumer<EventAttendesViewModel>(
              builder: (context, eventAttendesViewModel, child) {
            return ListView.builder(
              itemCount: eventAttendesViewModel.allAttendes?.length ?? 0,
              itemBuilder: (context, index) {
                return EventAttendeListItem(
                  eventAttende: eventAttendesViewModel.allAttendes![index],
                  function: () {},
                );
              },
            );
          })),
    );
  }
}
