import 'package:deu_cis/product/models/event_session_rate.dart';
import 'package:deu_cis/product/models/user_notes.dart';
import 'package:deu_cis/product/services/model_service/event_session_istatistics_service.dart';
import 'package:deu_cis/product/services/model_service/user_note_service.dart';
import 'package:flutter/material.dart';

class EventSessionIstatisticsViewModel extends ChangeNotifier {
  List<EventSessioRate>? _eventSessioRates;
  List<EventSessioRate>? get eventSessioRates => _eventSessioRates;
  IEventSessionIstatisticsService _userNoteService =
      EventSessionIstatisticsService();

  Future<void> fetchEventSessioRates(int eventID) async {
    _eventSessioRates = null;
    _eventSessioRates = await _getEventSessioRates(eventID);
    notifyListeners();
  }

  Future<List<EventSessioRate>?> _getEventSessioRates(int eventID) async {
    return await _userNoteService.getEventSessionRates(eventID);
  }
}
