import 'package:deu_cis/feature/home/subview/events/event_detail/subview/event_attendes_view.dart';
import 'package:deu_cis/product/vm/event_agenda_view_model.dart';
import 'package:deu_cis/feature/home/subview/events/event_detail/subview/event_agenda_list_view.dart';
import 'package:deu_cis/feature/home/subview/events/event_detail/subview/subview/event_speakers_view.dart';
import 'package:deu_cis/feature/home/subview/events/event_detail/subview/event_home_view.dart';
import 'package:deu_cis/feature/home/subview/events/event_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/model/tab_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/vm/event_attendes_view_model.dart';
import 'package:flutter/material.dart';

class EventDetailView extends StatefulWidget {
  EventDetailView({
    super.key,
  });

  @override
  State<EventDetailView> createState() => _EventDetailViewState();
}

class _EventDetailViewState extends State<EventDetailView>
    with TickerProviderStateMixin {
  bool _isLoading = true;
  final List<TabItem> _tabs = [
    TabItem(
        title: StringConsts.home,
        icon: Icon(Icons.home),
        child: EventHomeView()),
    TabItem(
        title: StringConsts.agenda,
        icon: Icon(Icons.calendar_month),
        child: EventAgendaListView()),
    TabItem(
        title: StringConsts.attendees,
        icon: Icon(Icons.groups),
        child: EventAttendesView()),
  ];
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    _tabController = TabController(length: _tabs.length, vsync: this);
    int eventID = locator<EventViewModel>().selectedEvent!.id!;
    await locator<EventAgendaViewModel>().fetchEventSessions(eventID);
    await locator<EventAttendesViewModel>().fetchEventAttendes(eventID);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            backgroundColor: AppColors.themeColor,
            body: SafeArea(
              child: TabBarView(
                  controller: _tabController,
                  children: _tabs.map((e) => e.child).toList()),
            ),
            bottomNavigationBar: Container(
              color: AppColors.white,
              child: TabBar(
                controller: _tabController,
                tabs:
                    _tabs.map((e) => Tab(text: e.title, icon: e.icon)).toList(),
              ),
            ),
          );
  }
}
