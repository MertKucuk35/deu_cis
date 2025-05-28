import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_attende.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IEventAttendeService {
  Future<List<EventAttende>?> getEventAttendes(int eventID);
}

class EventAttendeService implements IEventAttendeService {
  @override
  Future<List<EventAttende>?> getEventAttendes(int eventID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.attendes.name, '', {"eventID": eventID});
      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<EventAttende> eventAttendes =
            decoded.map((attende) => EventAttende.fromMap(attende)).toList();

        return eventAttendes;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }
}
