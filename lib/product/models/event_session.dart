// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/speaker_mini.dart';

class EventSession extends BaseEventSession {
  bool isAdded = false;
  EventSession(
      {required super.id,
      required super.eventId,
      required super.startDate,
      required super.endDate,
      required super.title,
      required super.description,
      required super.location,
      required this.isAdded});

  EventSession.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    startDate = DateTime.tryParse(json['start_date'] as String);
    endDate = DateTime.tryParse(json['end_date'] as String);
    title = json['title'];
    description = json['description'];
    location = json['location'];
    if (json['speaker'] != null) {
      speaker = <SpeakerMini>[];
      json['speaker'].forEach((v) {
        speaker!.add(new SpeakerMini.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_id'] = this.eventId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['title'] = this.title;
    data['description'] = this.description;
    data['location'] = this.location;
    if (this.speaker != null) {
      data['speaker'] = this.speaker!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJson() => json.encode(toMap());

  factory EventSession.fromJson(String source) =>
      EventSession.fromMap(json.decode(source) as Map<String, dynamic>);

  EventSession copyWith({
    int? id,
    int? eventId,
    DateTime? startDate,
    DateTime? endDate,
    String? title,
    String? description,
    String? location,
    bool? isAdded,
  }) {
    return EventSession(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      isAdded: isAdded ?? this.isAdded,
    );
  }
}
