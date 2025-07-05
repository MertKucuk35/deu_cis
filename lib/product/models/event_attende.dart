import 'dart:convert';

import 'package:deu_cis/product/enums/event_roles.dart';
import 'package:flutter/foundation.dart';

class EventAttende {
  int? userId;
  String? firstName;
  String? lastName;
  String? photoUrl;
  String? role;
  String? position;
  String? title;
  String? institutionName;

  EventAttende(
      {this.userId,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.role,
      this.position,
      this.title,
      this.institutionName});

  bool isSpeaker() {
    if (role == EventRoles.speaker.name) {
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

  EventAttende.fromMap(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    photoUrl = json['photo_url'];
    role = json['role'];
    position = json['position'];
    title = json['title'];
    institutionName = json['institution_name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['photo_url'] = this.photoUrl;
    data['role'] = this.role;
    data['position'] = this.position;
    data['title'] = this.title;
    data['institution_name'] = this.institutionName;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory EventAttende.fromJson(String source) =>
      EventAttende.fromMap(json.decode(source) as Map<String, dynamic>);
}

// import 'dart:convert';
// import 'package:deu_cis/product/models/base/base_event_people.dart';

// class EventAttende extends BaseEventPeople {
//   EventAttende(
//       {required super.userId,
//       required super.firstName,
//       required super.lastName,
//       required super.photoUrl,
//       super.role});

//   EventAttende.fromMap(Map<String, dynamic> json) {
//     userId = json['user_id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     photoUrl = json['photo_url'];
//     role = json['role'];
//   }

//   Map<String, dynamic> toMap() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['user_id'] = this.userId;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['photo_url'] = this.photoUrl;
//     data['role'] = this.role;
//     return data;
//   }

//   String toJson() => json.encode(toMap());

//   factory EventAttende.fromJson(String source) =>
//       EventAttende.fromMap(json.decode(source) as Map<String, dynamic>);
// }
