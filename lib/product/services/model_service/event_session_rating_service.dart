import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:deu_cis/product/models/user_session_rate.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IEventSessionRatingService {
  // Future<List<EventSession>?> getUserSessionRating(int eventID, int userID);
  Future<UserSessionRate?> getUserSessionRating(int sessionID, int userID);
  // Future<List<UserAgendaSession>?> getUserAgenda(int userID);
  Future<UserSessionRate?> addUserSessionRating(
      UserSessionRate userSessionRate);
  Future<UserSessionRate?> updateUserSessionRating(
      UserSessionRate userSessionRate);
}

class EventSessionRatingService implements IEventSessionRatingService {
  @override
  Future<UserSessionRate?> getUserSessionRating(
      int sessionID, int userID) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.ratings.name,
          RatingsEndpoints.user_session_rating.name,
          {"session_id": sessionID, "user_id": userID});
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userSessionRate = UserSessionRate.fromMap(decoded);
        return userSessionRate;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<UserSessionRate?> addUserSessionRating(
      UserSessionRate userSessionRate) async {
    try {
      final response = await HttpHelper.postRequest(MainEndPoints.ratings.name,
          RatingsEndpoints.user_session_rating_add.name, {
        "user_id": userSessionRate.userId,
        "session_id": userSessionRate.eventSessionId,
        "quest1": userSessionRate.q1ExpectationScore,
        "quest2": userSessionRate.q2PresentationScore,
        "quest3": userSessionRate.q3MasteryScore,
        "quest4": userSessionRate.q4TopicAlignmentScore,
        "quest5": userSessionRate.q5OverallScore,
        "quest6": userSessionRate.q6Recommendation,
        "comment": userSessionRate.comment,
      });
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userSessionRate = UserSessionRate.fromMap(decoded);
        return userSessionRate;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<UserSessionRate?> updateUserSessionRating(
      UserSessionRate userSessionRate) async {
    try {
      final response = await HttpHelper.patchRequest(MainEndPoints.ratings.name,
          RatingsEndpoints.user_session_rating_update.name, {
        "id": userSessionRate.id,
        "q1_expectation_score": userSessionRate.q1ExpectationScore,
        "q2_presentation_score": userSessionRate.q2PresentationScore,
        "q3_mastery_score": userSessionRate.q3MasteryScore,
        "q4_topic_alignment_score": userSessionRate.q4TopicAlignmentScore,
        "q5_overall_score": userSessionRate.q5OverallScore,
        "q6_recommendation": userSessionRate.q6Recommendation,
        "comment": userSessionRate.comment,
      });
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userSessionRate = UserSessionRate.fromMap(decoded);
        return userSessionRate;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }
}
