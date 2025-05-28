import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IEventService {
  Future<List<Event>?> getEvents();
  Future<Event?> getEventById(String id);
}

class EventService implements IEventService {
  @override
  Future<List<Event>?> getEvents() async {
    try {
      final response = await HttpHelper.getRequest(
        MainEndPoints.events.name,
        '',
      );
      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<Event> events =
            decoded.map((event) => Event.fromMap(event)).toList();

        return events;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<Event?> getEventById(String id) async {}
}
