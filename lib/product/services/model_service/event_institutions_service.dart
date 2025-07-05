import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/event_organizer.dart';
import 'package:deu_cis/product/models/event_sponsor.dart';
import 'package:deu_cis/product/models/historys.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IEventInstitutionsService {
  Future<List<EventSponsor>?> getEventSponsors(int eventID);
  Future<List<EventOrganizer>?> getEventOrganizers(int eventID);
  Future<Historys?> getHistorys(int institutionID);
}

class EventInstitutionsService implements IEventInstitutionsService {
  @override
  Future<List<EventSponsor>?> getEventSponsors(int eventID) async {
    try {
      final response = await HttpHelper.postRequest(
        MainEndPoints.institutions.name,
        InstitutionsEndpoints.sponsors.name,
        {"eventID": eventID},
      );
      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<EventSponsor> sponsors =
            decoded.map((sponsor) => EventSponsor.fromMap(sponsor)).toList();

        return sponsors;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<List<EventOrganizer>?> getEventOrganizers(int eventID) async {
    try {
      final response = await HttpHelper.postRequest(
        MainEndPoints.institutions.name,
        InstitutionsEndpoints.organizers.name,
        {"eventID": eventID},
      );
      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<EventOrganizer> organizers = decoded
            .map((organizer) => EventOrganizer.fromMap(organizer))
            .toList();

        return organizers;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<Historys?> getHistorys(int institutionID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.institutions.name,
          InstitutionsEndpoints.institution_history.name, {
        'institutionID': institutionID,
      });
      if (response.statusCode < 300) {
        final history = Historys.fromJson(response.body);
        return history;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }
}
