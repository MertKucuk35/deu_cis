import 'package:deu_cis/product/models/user_session_rate.dart';
import 'package:deu_cis/product/services/model_service/event_session_rating_service.dart';
import 'package:flutter/widgets.dart';

class SessionRatingViewModel extends ChangeNotifier {
  UserSessionRate? _userSessionRate;
  UserSessionRate? get userSessionRate => _userSessionRate;
  IEventSessionRatingService _eventSessionRatingService =
      EventSessionRatingService();

  Future<void> fetchUserSessionRate(int sessionID, int userID) async {
    _userSessionRate =
        UserSessionRate(userId: userID, eventSessionId: sessionID);
    var result = await _eventSessionRatingService.getUserSessionRating(
        sessionID, userID);
    if (result != null) {
      _userSessionRate = result;
    }
    notifyListeners();
  }

  Future<UserSessionRate?> getUserSessionRating(
      int sessionID, int userID) async {
    var result = await _eventSessionRatingService.getUserSessionRating(
        sessionID, userID);
    return result;
  }

  Future<bool> addUserSessionRating(UserSessionRate usernRate) async {
    _userSessionRate =
        await _eventSessionRatingService.addUserSessionRating(usernRate);
    notifyListeners();
    if (_userSessionRate != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUserSessionRating(UserSessionRate userRate) async {
    _userSessionRate =
        await _eventSessionRatingService.updateUserSessionRating(userRate);
    notifyListeners();
    if (_userSessionRate != null) {
      return true;
    } else {
      return false;
    }
  }

  // Yeni metodlar - View'dan çağrılacak
  void updateExpectationScore(int? score) {
    if (_userSessionRate != null) {
      _userSessionRate = userSessionRate!.copyWith(q1ExpectationScore: score);
      notifyListeners();
    }
  }

  void updatePresentationScore(int? score) {
    if (_userSessionRate != null) {
      _userSessionRate = _userSessionRate!.copyWith(q2PresentationScore: score);
      notifyListeners();
    }
  }

  void updateMasteryScore(int? score) {
    if (_userSessionRate != null) {
      _userSessionRate = _userSessionRate!.copyWith(q3MasteryScore: score);
      notifyListeners();
    }
  }

  void updateTopicAlignmentScore(int? score) {
    if (_userSessionRate != null) {
      _userSessionRate =
          _userSessionRate!.copyWith(q4TopicAlignmentScore: score);
      notifyListeners();
    }
  }

  void updateOverallScore(int? score) {
    if (_userSessionRate != null) {
      _userSessionRate = _userSessionRate!.copyWith(q5OverallScore: score);
      notifyListeners();
    }
  }

  void updateRecommendation(int? recommendation) {
    if (_userSessionRate != null) {
      _userSessionRate =
          _userSessionRate!.copyWith(q6Recommendation: recommendation);
      notifyListeners();
    }
  }

  void updateComment(String? comment) {
    if (_userSessionRate != null) {
      _userSessionRate = _userSessionRate!.copyWith(comment: comment);
      notifyListeners();
    }
  }
}
