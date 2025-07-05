import 'dart:convert';

import 'package:deu_cis/feature/home/subview/events/event_desc_view.dart';
import 'package:deu_cis/product/vm/event_view_model.dart';

import 'package:deu_cis/product/common/widget/event_list_item.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventsListView extends StatefulWidget {
  const EventsListView({super.key});

  @override
  State<EventsListView> createState() => _EventsListViewState();
}

class _EventsListViewState extends State<EventsListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyLight,
        body: ChangeNotifierProvider.value(
            value: locator<EventViewModel>(),
            child: Consumer<EventViewModel>(
                builder: (context, eventViewModel, child) {
              return ListView.builder(
                itemCount: eventViewModel.events?.length ?? 0,
                itemBuilder: (context, index) {
                  return EventListItem(
                      imageNeed: true,
                      icon: Icon(Icons.arrow_forward_ios),
                      event: eventViewModel.events![index],
                      function: () {
                        locator<EventViewModel>()
                            .setSelectedEvent(eventViewModel.events![index]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDescriptionView(),
                          ),
                        );
                      });
                },
              );
            })));
  }
}
