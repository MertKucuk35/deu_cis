import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IEventSessionService {
  Future<List<EventSession>?> getEventSessions(int eventID);
  Future<List<UserAgendaSession>?> getUserAgenda(int userID);
  Future<UserAgendaSession?> addUserAgenda(int agendaSessionID, int userID);
  Future<void> deleteUserAgenda(int agendaSessionID);
}

class EventSessionService implements IEventSessionService {
  @override
  Future<List<EventSession>?> getEventSessions(int eventID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.event_sessions.name, '', {"id": eventID});
      if (response.statusCode < 300) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<EventSession> eventSessions =
            decoded.map((session) => EventSession.fromMap(session)).toList();

        return eventSessions;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<List<UserAgendaSession>?> getUserAgenda(int userID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.event_sessions.name,
          EventSessionsEndpoints.user_agenda.name,
          {"id": userID});
      if (response.statusCode < 300) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<UserAgendaSession> userAgendaSessions = decoded
            .map((session) => UserAgendaSession.fromMap(session))
            .toList();

        return userAgendaSessions;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<UserAgendaSession?> addUserAgenda(
      int agendaSessionID, int userID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.event_sessions.name,
          EventSessionsEndpoints.user_agenda_add.name,
          {"user_id": userID, "session_id": agendaSessionID});
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userAgendaSession = UserAgendaSession.fromMap(decoded);
        return userAgendaSession;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<void> deleteUserAgenda(int userAgendaSessionID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.event_sessions.name,
          EventSessionsEndpoints.user_agenda_delete.name,
          {"id": userAgendaSessionID});
      if (response.statusCode > 300) {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
  }
}
