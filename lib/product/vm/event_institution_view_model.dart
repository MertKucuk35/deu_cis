import 'package:deu_cis/product/models/base/base_institution.dart';
import 'package:deu_cis/product/models/event_organizer.dart';
import 'package:deu_cis/product/models/event_sponsor.dart';
import 'package:deu_cis/product/services/model_service/event_institutions_service.dart';
import 'package:flutter/material.dart';

class EventInstitutionViewModel extends ChangeNotifier {
  // Maple denenir
  List<EventOrganizer>? _eventOrganizers;
  List<EventOrganizer>? get eventOrganizers => _eventOrganizers;
  // EventOrganizer? _selectedEventOrganizer;
  // EventOrganizer? get selectedEventOrganizer => _selectedEventOrganizer;

  List<EventSponsor>? _eventSponsors;
  List<EventSponsor>? get eventSponsors => _eventSponsors;
  // EventSponsor? _selectedEventSponsor;
  // EventSponsor? get selectedEventSponsor => _selectedEventSponsor;

  BaseInstitution? _selectedInstitution;
  BaseInstitution? get selectedInstitution => _selectedInstitution;

  IEventInstitutionsService _eventInstitutionsService =
      EventInstitutionsService();

  Future<void> fetchEventInstitutions(int eventID) async {
    await getEventOrganizers(eventID);
    await getEventSponsor(eventID);
    notifyListeners();
  }

  Future<void> getEventOrganizers(int eventID) async {
    _eventOrganizers = null;
    _eventOrganizers =
        await _eventInstitutionsService.getEventOrganizers(eventID);
  }

  Future<void> getEventSponsor(int eventID) async {
    _eventSponsors = null;
    _eventSponsors = await _eventInstitutionsService.getEventSponsors(eventID);
  }

  void selectInstitution(BaseInstitution institution) {
    _selectedInstitution = institution;
    notifyListeners();
  }
  // void selectEventOrganizer(EventOrganizer eventOrganizer) {
  //   _selectedEventOrganizer = eventOrganizer;
  //   notifyListeners();
  // }

  // void selectEventSponsor(EventSponsor eventSponsor) {
  //   _selectedEventSponsor = eventSponsor;
  //   notifyListeners();
  // }
}
