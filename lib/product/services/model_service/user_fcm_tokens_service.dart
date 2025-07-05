import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:deu_cis/product/models/user_fcm_tokens.dart';
import 'package:deu_cis/product/models/user_session_rate.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IUserFcmTokensService {
  // Future<List<EventSession>?> getUserSessionRating(int eventID, int userID);
  Future<UserFcmTokens?> getUserFcmTokens(int userID);
  // Future<List<UserAgendaSession>?> getUserAgenda(int userID);
  Future<UserFcmTokens?> addUserFcmTokens(UserFcmTokens userFcmTokens);
  Future<UserFcmTokens?> updateUserFcmTokens(UserFcmTokens userFcmTokens);
}

class UserFcmTokensService implements IUserFcmTokensService {
  @override
  Future<UserFcmTokens?> addUserFcmTokens(UserFcmTokens userFcmTokens) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.fcm_tokens.name,
          FcmTokensEndpoints.user_fcm_tokens_add.name, {
        "user_id": userFcmTokens.userId,
        "mobile_fcm_token": userFcmTokens.mobileFcmToken,
        "web_fcm_token": userFcmTokens.webFcmToken
      });
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userFcmTokens = UserFcmTokens.fromMap(decoded);
        return userFcmTokens;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<UserFcmTokens?> updateUserFcmTokens(
      UserFcmTokens userFcmTokens) async {
    try {
      final response = await HttpHelper.patchRequest(
          MainEndPoints.fcm_tokens.name,
          FcmTokensEndpoints.user_fcm_tokens_update.name, {
        "user_id": userFcmTokens.userId,
        "mobile_fcm_token": userFcmTokens.mobileFcmToken,
        "web_fcm_token": userFcmTokens.webFcmToken
      });
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userFcmTokens = UserFcmTokens.fromMap(decoded);
        return userFcmTokens;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<UserFcmTokens?> getUserFcmTokens(int userID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.fcm_tokens.name,
          FcmTokensEndpoints.user_fcm_tokens.name,
          {"user_id": userID});
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userFcmTokens = UserFcmTokens.fromMap(decoded);
        return userFcmTokens;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }
}
