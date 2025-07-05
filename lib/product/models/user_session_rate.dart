// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserSessionRate {
  int? id;
  int? userId;
  int? eventSessionId;
  int? q1ExpectationScore;
  int? q2PresentationScore;
  int? q3MasteryScore;
  int? q4TopicAlignmentScore;
  int? q5OverallScore;
  int? q6Recommendation;
  String? comment;

  UserSessionRate(
      {this.id,
      this.userId,
      this.eventSessionId,
      this.q1ExpectationScore,
      this.q2PresentationScore,
      this.q3MasteryScore,
      this.q4TopicAlignmentScore,
      this.q5OverallScore,
      this.q6Recommendation,
      this.comment});

  UserSessionRate.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    eventSessionId = json['event_session_id'];
    q1ExpectationScore = json['q1_expectation_score'];
    q2PresentationScore = json['q2_presentation_score'];
    q3MasteryScore = json['q3_mastery_score'];
    q4TopicAlignmentScore = json['q4_topic_alignment_score'];
    q5OverallScore = json['q5_overall_score'];
    q6Recommendation = json['q6_recommendation'];
    comment = json['comment'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['event_session_id'] = this.eventSessionId;
    data['q1_expectation_score'] = this.q1ExpectationScore;
    data['q2_presentation_score'] = this.q2PresentationScore;
    data['q3_mastery_score'] = this.q3MasteryScore;
    data['q4_topic_alignment_score'] = this.q4TopicAlignmentScore;
    data['q5_overall_score'] = this.q5OverallScore;
    data['q6_recommendation'] = this.q6Recommendation;
    data['comment'] = this.comment;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory UserSessionRate.fromJson(String source) =>
      UserSessionRate.fromMap(json.decode(source) as Map<String, dynamic>);

  UserSessionRate copyWith({
    int? id,
    int? userId,
    int? eventSessionId,
    int? q1ExpectationScore,
    int? q2PresentationScore,
    int? q3MasteryScore,
    int? q4TopicAlignmentScore,
    int? q5OverallScore,
    int? q6Recommendation,
    String? comment,
  }) {
    return UserSessionRate(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventSessionId: eventSessionId ?? this.eventSessionId,
      q1ExpectationScore: q1ExpectationScore ?? this.q1ExpectationScore,
      q2PresentationScore: q2PresentationScore ?? this.q2PresentationScore,
      q3MasteryScore: q3MasteryScore ?? this.q3MasteryScore,
      q4TopicAlignmentScore:
          q4TopicAlignmentScore ?? this.q4TopicAlignmentScore,
      q5OverallScore: q5OverallScore ?? this.q5OverallScore,
      q6Recommendation: q6Recommendation ?? this.q6Recommendation,
      comment: comment ?? this.comment,
    );
  }
}
