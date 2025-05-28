import 'package:deu_cis/product/vm/user_agenda_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:deu_cis/product/services/model_service/event_session_service.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:flutter/material.dart';

class EventAgendaViewModel extends ChangeNotifier {
  List<EventSession>? _eventSessions;
  List<EventSession>? get eventSessions => _eventSessions;

  IEventSessionService _eventSessionService = EventSessionService();

  Future<void> fetchEventSessions(int eventID) async {
    _eventSessions = null;
    _eventSessions = await _eventSessionService.getEventSessions(eventID);
    controllIsAdded();
  }

  void controllIsAdded() {
    if (_eventSessions != null) {
      List<UserAgendaSession>? addedItems =
          locator<UserAgendaViewModel>().userAgendaList;
      if (addedItems != null && _eventSessions != null) {
        for (int i = 0; i < _eventSessions!.length; i++) {
          for (int k = 0; k < addedItems.length; k++) {
            if (_eventSessions![i].id == addedItems[k].sessionId) {
              _eventSessions![i].isAdded = true;
            }
          }
        }
      }
      notifyListeners();
    }
  }

  Future<void> changeEventSelected(int itemIndex) async {
    EventSession selectedItem = _eventSessions![itemIndex];
    if (selectedItem.isAdded) {
      await locator<UserAgendaViewModel>().deleteUserAgendaItem(
          locator<UserAgendaViewModel>()
              .searchEventSessionInAgenda(selectedItem.id!)!);
      _eventSessions![itemIndex].isAdded = false;
    } else {
      await locator<UserAgendaViewModel>()
          .addAgendaItem(selectedItem!.id!, locator<AuthViewModel>().user!.id);
      _eventSessions![itemIndex].isAdded = true;
    }
    notifyListeners();
  }
  // Future<void> changeSelectEventSession(EventSession event) async {
  //   if (event.isAdded) {
  //     await locator<UserAgendaViewModel>().deleteAgendaItem(
  //         locator<UserAgendaViewModel>()
  //             .searchEventSessionInAgenda(event!.id!));
  //     _eventSessions![_eventSessions!.indexOf(event)] =
  //         _eventSessions![_eventSessions!.indexOf(event)]
  //             .copyWith(isAdded: false);
  //     controllIsAdded();
  //   } else {
  //     await locator<UserAgendaViewModel>()
  //         .addAgendaItem(event!.id!, locator<AuthViewModel>().user!.id);
  //     _eventSessions![_eventSessions!.indexOf(event)] =
  //         _eventSessions![_eventSessions!.indexOf(event)]
  //             .copyWith(isAdded: true);
  //     controllIsAdded();
  //   }
  // }

  // Future<void> changeSelectEventSessionFromAgenda(int eventID) async {
  //   if (_eventSessions != null) {
  //     EventSession? searchedEvent = _eventSessions!.firstWhere(
  //       (element) => element.id == eventID,
  //     );

  //     if (searchedEvent != null) {
  //       _eventSessions![_eventSessions!.indexOf(searchedEvent)] =
  //           searchedEvent.copyWith(isAdded: false);
  //       controllIsAdded();
  //     }
  //   }
  // }
}
