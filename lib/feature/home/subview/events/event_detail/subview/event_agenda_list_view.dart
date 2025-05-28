import 'package:deu_cis/product/vm/event_agenda_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/agenda_list_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventAgendaListView extends StatefulWidget {
  const EventAgendaListView({super.key});

  @override
  State<EventAgendaListView> createState() => _EventAgendaListViewState();
}

class _EventAgendaListViewState extends State<EventAgendaListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        backgroundColor: AppColors.greyLight,
        body: ChangeNotifierProvider.value(
            value: locator<EventAgendaViewModel>(),
            child: Consumer<EventAgendaViewModel>(
                builder: (context, eventAgendaViewModel, child) {
              return ListView.builder(
                itemCount: eventAgendaViewModel.eventSessions?.length ?? 0,
                itemBuilder: (context, index) {
                  return AgendaListItem(
                    eventSession: eventAgendaViewModel.eventSessions?[index],
                    onTapFunction: () {},
                    trialingFunction: () async {
                      await eventAgendaViewModel.changeEventSelected(index);
                      // setState(() {});
                      // await locator<EventAgendaViewModel>()
                      //     .changeSelectEventSession(
                      //         eventAgendaViewModel.eventSessions![index]);
                    },
                  );
                },
              );
            })));
  }
}
