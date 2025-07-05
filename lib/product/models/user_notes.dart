import 'dart:convert';

import 'package:deu_cis/product/enums/user_note_types.dart';
import 'package:flutter/foundation.dart';

class UserNote {
  int? id;
  String? noteType;
  int? relevantId;
  int? userId;
  String? noteText;
  String? createdAt;
  String? updateAt;
  Meta? meta;

  UserNote(
      {this.id,
      this.noteType,
      this.relevantId,
      this.userId,
      this.noteText,
      this.createdAt,
      this.updateAt,
      this.meta});

  UserNote.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    noteType = json['note_type'];
    relevantId = json['relevant_id'];
    userId = json['user_id'];
    noteText = json['note_text'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    if (json['meta'] != null) {
      if (json['note_type'] == UserNoteTypes.person.name) {
        meta = PersonMeta.fromJson(json['meta']);
      } else {
        meta = EventSessionMeta.fromJson(json['meta']);
      }
    } else {
      meta = null;
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note_type'] = this.noteType;
    data['relevant_id'] = this.relevantId;
    data['user_id'] = this.userId;
    data['note_text'] = this.noteText;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    if (this.meta != null) {
      noteType == UserNoteTypes.person.name
          ? data['meta'] = (this.meta as PersonMeta).toJson()
          : data['meta'] = (this.meta as EventSessionMeta).toJson();
    }
    return data;
  }

  // String toJson() => json.encode(toMap());

  // factory UserNote.fromJson(String source) =>
  //     UserNote.fromMap(json.decode(source) as Map<String, dynamic>);
}

abstract class Meta {}

class PersonMeta extends Meta {
  int? personId;
  String? fullName;
  String? photoUrl;

  PersonMeta({this.personId, this.fullName, this.photoUrl});

  PersonMeta.fromJson(Map<String, dynamic> json) {
    personId = json['person_id'];
    fullName = json['full_name'];
    photoUrl = json['photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_id'] = this.personId;
    data['full_name'] = this.fullName;
    data['photo_url'] = this.photoUrl;
    return data;
  }

  String? getImageURL() {
    if (photoUrl == null) return null;

    return kIsWeb
        ? photoUrl?.replaceAll('localhost', '192.168.1.7:58507')
        : photoUrl?.replaceAll('localhost', '10.0.2.2');
  }
}

class EventSessionMeta extends Meta {
  int? sessionId;
  String? sessionTitle;
  DateTime? startDate;
  DateTime? endDate;

  EventSessionMeta(
      {this.sessionId, this.sessionTitle, this.startDate, this.endDate});

  EventSessionMeta.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    sessionTitle = json['session_title'];
    startDate = DateTime.tryParse(json['start_date'] as String);
    endDate = DateTime.tryParse(json['end_date'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['session_id'] = this.sessionId;
    data['session_title'] = this.sessionTitle;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
