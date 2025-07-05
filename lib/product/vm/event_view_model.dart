import 'package:deu_cis/product/vm/event_agenda_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/services/model_service/event_service.dart';
import 'package:flutter/material.dart';

class EventViewModel extends ChangeNotifier {
  IEventService _eventService = EventService();
  List<Event>? _events;
  List<Event>? get events => _events;
  Event? _selectedEvent;
  Event? get selectedEvent => _selectedEvent;

  Future<void> fetchEvents() async {
    _events = await _eventService.getEvents();
    notifyListeners();
  }

  void setSelectedEvent(Event event) {
    _selectedEvent = event;
    notifyListeners();
  }
}
