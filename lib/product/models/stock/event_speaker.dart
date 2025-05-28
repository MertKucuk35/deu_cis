// import 'dart:convert';

// import 'package:deu_cis/product/enums/event_roles.dart';
// import 'package:deu_cis/product/models/base/base_event_people.dart';

// class EventSpeaker extends BaseEventPeople {
//   EventSpeaker(
//       {required super.userId,
//       required super.firstName,
//       required super.lastName,
//       required super.photoUrl,
//       super.role});

//   EventSpeaker.fromMap(Map<String, dynamic> json) {
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

//   factory EventSpeaker.fromJson(String source) =>
//       EventSpeaker.fromMap(json.decode(source) as Map<String, dynamic>);
// }
