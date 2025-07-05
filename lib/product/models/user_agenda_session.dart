// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/mini/speaker_mini.dart';
import 'package:deu_cis/product/models/user_notes.dart';

class UserAgendaSession extends BaseEventSession {
  int? sessionId;

  UserAgendaSession(
      {required super.id,
      required this.sessionId,
      required super.eventId,
      required super.title,
      required super.description,
      required super.location,
      required super.startDate,
      required super.endDate,
      required super.userNote,
      required super.speaker});

  UserAgendaSession.fromMap(Map<String, dynamic> json) {
    id = json['user_session_id'];
    sessionId = json['session_id'];
    eventId = json['event_id'];
    title = json['title'];
    description = json['description'];

    location = json['location'];
    startDate = DateTime.tryParse(json['start_date'] as String);
    endDate = DateTime.tryParse(json['end_date'] as String);
    if (json['speaker'] != null) {
      speaker = <SpeakerMini>[];
      json['speaker'].forEach((v) {
        speaker!.add(new SpeakerMini.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_session_id'] = this.id;
    data['session_id'] = this.sessionId;
    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['user_note'] = this.userNote;
    if (this.speaker != null) {
      data['speaker'] = this.speaker!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJson() => json.encode(toMap());

  factory UserAgendaSession.fromJson(String source) =>
      UserAgendaSession.fromMap(json.decode(source) as Map<String, dynamic>);

  UserAgendaSession copyWith({
    int? sessionId,
    int? id,
    int? eventId,
    String? title,
    String? description,
    String? location,
    DateTime? startDate,
    DateTime? endDate,
    List<SpeakerMini>? speaker,
    UserNote? userNote,
  }) {
    return UserAgendaSession(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      speaker: speaker ?? this.speaker,
      userNote: userNote ?? this.userNote,
    );
  }
}
