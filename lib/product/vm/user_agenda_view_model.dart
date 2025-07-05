import 'package:deu_cis/product/vm/event_agenda_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:deu_cis/product/services/model_service/event_session_service.dart';
import 'package:flutter/material.dart';

class UserAgendaViewModel extends ChangeNotifier {
  List<UserAgendaSession>? _userAgendaList;
  List<UserAgendaSession>? get userAgendaList => _userAgendaList;

  IEventSessionService _eventSessionService = EventSessionService();

  Future<void> fetchUserAgenda(int userID) async {
    _userAgendaList = null;
    _userAgendaList = await getUserAgenda(userID);
    notifyListeners();
  }

  Future<List<UserAgendaSession>?> getUserAgenda(int userID) async {
    return await _eventSessionService.getUserAgenda(userID);
  }

  Future<void> deleteUserAgendaItem(int itemIndex) async {
    _eventSessionService.deleteUserAgenda(_userAgendaList![itemIndex].id!);
    _userAgendaList!.removeAt(itemIndex);
    notifyListeners();
  }

  Future<void> addAgendaItem(int agendaSessionID, int userID) async {
    UserAgendaSession? added =
        await _eventSessionService.addUserAgenda(agendaSessionID, userID);
    _userAgendaList!.add(added!);
  }

  int? searchEventSessionInAgenda(int eventID) {
    for (int i = 0; i < _userAgendaList!.length!; i++) {
      if (_userAgendaList![i].sessionId == eventID) {
        return i;
      }
    }
  }
}
