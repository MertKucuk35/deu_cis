import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/user_chat_messages.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IUserChatMessagesService {
  Future<List<UserChatMessages>?> getUserChatMessages(
      int userID, int recieverID);
  // Future<Event?> getEventById(String id);
}

class UserChatMessagesService implements IUserChatMessagesService {
  @override
  Future<List<UserChatMessages>?> getUserChatMessages(
      int userID, int recieverID) async {
    try {
      final response = await HttpHelper.postRequest(
        MainEndPoints.messages.name,
        MessagesEndpoints.user_chat_messages.name,
        {"user_id": userID, "reciever_id": recieverID},
      );
      if (response.statusCode == 200) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<UserChatMessages> userChatMessages =
            decoded.map((event) => UserChatMessages.fromMap(event)).toList();

        return userChatMessages;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  // @override
  // Future<Event?> getEventById(String id) async {}
}
