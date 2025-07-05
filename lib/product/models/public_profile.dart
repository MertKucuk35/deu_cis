import 'dart:convert';

import 'package:deu_cis/product/enums/user_roles.dart';
import 'package:deu_cis/product/models/user_notes.dart';
import 'package:flutter/foundation.dart';

class PublicProfile {
  int? id;
  String? userType;
  String? title;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? bioText;
  List<Education>? education;
  List<Affillations>? affillations;
  List<SpeakEvent>? speakEvent;
  UserNote? userNote;

  PublicProfile(
      {this.id,
      this.userType,
      this.title,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.bioText,
      this.education,
      this.affillations,
      this.speakEvent,
      this.userNote});
  bool isSpeaker() {
    if (speakEvent != null && speakEvent!.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  bool isPrimaryContact() {
    if (userType != null && userType == UserRoles.institution_manager.name) {
      return true;
    } else {
      return false;
    }
  }

  String? getImageURL() {
    if (photoUrl != null) {
      return kIsWeb
          ? photoUrl!.replaceAll('localhost', '192.168.1.7:58507')
          : photoUrl!.replaceAll('localhost', '10.0.2.2');
    } else
      return null;
  }

  PublicProfile.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    photoUrl = json['photo_url'];
    bioText = json['bio_text'];
    if (json['education'] != null) {
      education = <Education>[];
      json['education'].forEach((v) {
        education!.add(new Education.fromJson(v));
      });
    }
    if (json['affillations'] != null) {
      affillations = <Affillations>[];
      json['affillations'].forEach((v) {
        affillations!.add(new Affillations.fromJson(v));
      });
    }
    if (json['speak_event'] != null) {
      speakEvent = <SpeakEvent>[];
      json['speak_event'].forEach((v) {
        speakEvent!.add(new SpeakEvent.fromJson(v));
      });
    }
    userNote = json['note'] != null ? UserNote.fromMap(json['note']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_type'] = this.userType;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['photo_url'] = this.photoUrl;
    data['bio_text'] = this.bioText;
    if (this.education != null) {
      data['education'] = this.education!.map((v) => v.toJson()).toList();
    }
    if (this.affillations != null) {
      data['affillations'] = this.affillations!.map((v) => v.toJson()).toList();
    }
    if (this.speakEvent != null) {
      data['speak_event'] = this.speakEvent!.map((v) => v.toJson()).toList();
    }
    if (this.userNote != null) {
      data['note'] = this.userNote!.toMap();
    }
    return data;
  }

  String toJson() => json.encode(toMap());

  factory PublicProfile.fromJson(String source) =>
      PublicProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Education {
  int? educationId;
  DateTime? startDate;
  DateTime? endDate;
  String? universityName;
  String? degree;
  String? department;

  Education(
      {this.educationId,
      this.startDate,
      this.endDate,
      this.universityName,
      this.degree,
      this.department});

  Education.fromJson(Map<String, dynamic> json) {
    educationId = json['education_id'];
    startDate = DateTime.tryParse(json['start_date'] as String);
    endDate = json['end_date'] != null
        ? DateTime.tryParse(json['end_date'] as String)
        : null;
    universityName = json['university_name'];
    degree = json['degree'];
    department = json['department'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['education_id'] = this.educationId;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['university_name'] = this.universityName;
    data['degree'] = this.degree;
    data['department'] = this.department;
    return data;
  }
}

class Affillations {
  int? id;
  String? institutionName;
  String? position;
  DateTime? startDate;
  DateTime? endDate;
  String? createdDate;
  int? listIndex;

  Affillations(
      {this.id,
      this.institutionName,
      this.position,
      this.startDate,
      this.endDate,
      this.createdDate,
      this.listIndex});

  Affillations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    institutionName = json['institution_name'];
    position = json['position'];
    startDate = DateTime.tryParse(json['start_date'] as String);
    endDate = json['end_date'] != null
        ? DateTime.tryParse(json['end_date'] as String)
        : null;
    createdDate = json['created_date'];
    listIndex = json['list_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['institution_name'] = this.institutionName;
    data['position'] = this.position;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['created_date'] = this.createdDate;
    data['list_index'] = this.listIndex;
    return data;
  }
}

class SpeakEvent {
  int? id;
  int? sessionID;
  DateTime? startDate;
  DateTime? endDate;
  String? title;
  String? location;

  SpeakEvent(
      {this.id,
      this.startDate,
      this.endDate,
      this.title,
      this.location,
      this.sessionID});

  SpeakEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionID = json['session_id'];
    startDate = DateTime.tryParse(json['start_date'] as String);
    endDate = json['end_date'] != null
        ? DateTime.tryParse(json['end_date'] as String)
        : null;
    title = json['title'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['session_id'] = this.sessionID;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['title'] = this.title;
    data['location'] = this.location;
    return data;
  }
}

// class Note {
//   int? id;
//   String? noteType;
//   int? relevantId;
//   int? userId;
//   String? noteText;
//   String? createdAt;

//   Note(
//       {this.id,
//       this.noteType,
//       this.relevantId,
//       this.userId,
//       this.noteText,
//       this.createdAt});

//   Note.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     noteType = json['note_type'];
//     relevantId = json['relevant_id'];
//     userId = json['user_id'];
//     noteText = json['note_text'];
//     createdAt = json['created_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['note_type'] = this.noteType;
//     data['relevant_id'] = this.relevantId;
//     data['user_id'] = this.userId;
//     data['note_text'] = this.noteText;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }
