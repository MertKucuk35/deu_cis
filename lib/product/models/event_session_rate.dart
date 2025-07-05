import 'dart:convert';

class EventSessioRate {
  int? sessionId;
  String? sessionTitle;
  String? totalScore;
  int? totalVotes;
  String? averageScore;
  int? totalListAdditions;
  List<Speakers>? speakers;

  EventSessioRate(
      {this.sessionId,
      this.sessionTitle,
      this.totalScore,
      this.totalVotes,
      this.averageScore,
      this.totalListAdditions,
      this.speakers});

  EventSessioRate.fromMap(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    sessionTitle = json['session_title'];
    totalScore = json['total_score'];
    totalVotes = json['total_votes'];
    averageScore = json['average_score'];
    totalListAdditions = json['total_list_additions'];
    if (json['speakers'] != null) {
      speakers = <Speakers>[];
      json['speakers'].forEach((v) {
        speakers!.add(new Speakers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['session_title'] = this.sessionTitle;
    data['total_score'] = this.totalScore;
    data['total_votes'] = this.totalVotes;
    data['average_score'] = this.averageScore;
    data['total_list_additions'] = this.totalListAdditions;
    if (this.speakers != null) {
      data['speakers'] = this.speakers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJson() => json.encode(toMap());

  factory EventSessioRate.fromJson(String source) =>
      EventSessioRate.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Speakers {
  int? userId;
  String? fullName;
  String? photoUrl;
  String? institutionName;
  String? position;

  Speakers(
      {this.userId,
      this.fullName,
      this.photoUrl,
      this.institutionName,
      this.position});

  Speakers.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    photoUrl = json['photo_url'];
    institutionName = json['institution_name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['photo_url'] = this.photoUrl;
    data['institution_name'] = this.institutionName;
    data['position'] = this.position;
    return data;
  }
}
