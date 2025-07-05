import 'package:deu_cis/product/services/model_service/event_session_service.dart';
import 'package:flutter/material.dart';
import '../models/event_session.dart';
import '../models/user_agenda_session.dart';

class CombinedAgendaViewModel extends ChangeNotifier {
  final IEventSessionService _eventSessionService = EventSessionService();

  List<EventSession>? _eventSessions;
  List<UserAgendaSession>? _userAgendaList;

  List<EventSession>? get eventSessions => _eventSessions;
  List<UserAgendaSession>? get userAgendaList => _userAgendaList;

  Future<void> fetchData({required int userID, required int eventID}) async {
    _eventSessions = await getEventSessions(eventID, userID);
    _userAgendaList = await getUserAgenda(userID);
    _updateIsAddedStatus();
    notifyListeners();
  }

  Future<List<EventSession>?> getEventSessions(int eventID, int userID) async {
    return await _eventSessionService.getEventSessions(eventID, userID);
  }

  Future<List<UserAgendaSession>?> getUserAgenda(int userID) async {
    return await _eventSessionService.getUserAgenda(userID);
  }

  void _updateIsAddedStatus() {
    if (_eventSessions == null || _userAgendaList == null) return;
    for (var event in _eventSessions!) {
      event.isAdded =
          _userAgendaList!.any((agenda) => agenda.sessionId == event.id);
    }
  }

  Future<void> addToAgenda(int userID, EventSession session) async {
    UserAgendaSession? newItem =
        await _eventSessionService.addUserAgenda(userID, session.id!);
    _userAgendaList?.add(newItem!);
    session.isAdded = true;
    notifyListeners();
  }

  Future<void> removeFromAgenda(int userID, EventSession session) async {
    await _eventSessionService.deleteUserAgenda(session.id!);
    _userAgendaList?.removeWhere((item) => item.sessionId == session.id);
    session.isAdded = false;
    notifyListeners();
  }
}
