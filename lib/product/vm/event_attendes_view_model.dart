import 'package:deu_cis/product/vm/event_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/models/event_attende.dart';
import 'package:deu_cis/product/services/model_service/event_attende_service.dart';
import 'package:flutter/material.dart';

class EventAttendesViewModel extends ChangeNotifier {
  List<EventAttende>? _allAttendes;
  List<EventAttende>? get allAttendes => _allAttendes;

  IEventAttendeService _eventAttendeService = EventAttendeService();

  Future<void> fetchEventAttendes(int eventID) async {
    _allAttendes = await _eventAttendeService.getEventAttendes(eventID);
    notifyListeners();
  }

  List<EventAttende> get speakers =>
      _allAttendes!.where((user) => user.role == "speaker").toList();

  List<EventAttende> get attendees =>
      _allAttendes!.where((user) => user.role == "attendee").toList();
}
