import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/models/event_session_rate.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:deu_cis/product/models/user_session_rate.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IEventSessionIstatisticsService {
  // Future<List<EventSession>?> getUserSessionRating(int eventID, int userID);
  Future<List<EventSessioRate>?> getEventSessionRates(int eventID);
  // Future<List<UserAgendaSession>?> getUserAgenda(int userID);
}

class EventSessionIstatisticsService
    implements IEventSessionIstatisticsService {
  @override
  Future<List<EventSessioRate>?> getEventSessionRates(int eventID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.istatistics.name,
          IstatisticsEndPoints.top_rated_sessions.name,
          {"event_id": eventID});
      if (response.statusCode < 300) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<EventSessioRate> eventSessioRates =
            decoded.map((session) => EventSessioRate.fromMap(session)).toList();

        return eventSessioRates;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }
}
