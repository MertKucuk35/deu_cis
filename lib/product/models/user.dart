import 'dart:convert';

import 'package:deu_cis/product/enums/user_roles.dart';
import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final int id;
  String firstName;
  String lastName;
  String phoneNumber;
  String? imageUrl;
  DateTime bornDate;
  String gender;
  String tcNo;
  bool statusCode;
  String email;
  String jwtToken;
  String? password;
  String? userProfileURL;
  String userType;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      this.imageUrl,
      required this.jwtToken,
      required this.bornDate,
      required this.gender,
      required this.tcNo,
      required this.statusCode,
      required this.email,
      required this.password,
      required this.userType,
      required this.userProfileURL});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'imageUrl': imageUrl,
      'born_date': bornDate.millisecondsSinceEpoch,
      'gender': gender,
      'tc_no': tcNo,
      'status_code': statusCode,
      'email': email,
      'password': password,
      'user_type': userType,
      'user_profile': userProfileURL,
    };
  }

  bool isAdmin() {
    if (userType == UserRoles.admin.name) {
      return true;
    } else {
      return false;
    }
  }

  String? getImageURL() {
    if (userProfileURL != null) {
      return kIsWeb
          ? userProfileURL!.replaceAll('localhost', '192.168.1.7:58507')
          : userProfileURL!.replaceAll('localhost', '10.0.2.2');
    } else
      return null;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      firstName: map['first_name'] as String,
      lastName: map['last_name'] as String,
      phoneNumber: map['phone_number'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      bornDate: DateTime.parse(map['born_date']),
      gender: map['gender'] as String,
      tcNo: map['tc_no'] as String,
      jwtToken: map['token'] as String,
      statusCode: map['status_code'] == 1,
      email: map['email'] as String,
      password: map['password'] as String?,
      userProfileURL: map['user_profile'] as String?,
      userType: map['user_type'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  User copyWith({
    int? id,
    String? name,
    String? lastName,
    String? phoneNumber,
    String? imageUrl,
    DateTime? bornDate,
    String? gender,
    String? tcNo,
    String? jwtToken,
    bool? statusCode,
    String? email,
    String? password,
    String? userType,
    String? userProfileURL,
  }) {
    return User(
      id: id ?? this.id,
      firstName: name ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      imageUrl: imageUrl ?? this.imageUrl,
      bornDate: bornDate ?? this.bornDate,
      jwtToken: jwtToken ?? this.jwtToken,
      gender: gender ?? this.gender,
      tcNo: tcNo ?? this.tcNo,
      statusCode: statusCode ?? this.statusCode,
      email: email ?? this.email,
      password: password ?? this.password,
      userType: userType ?? this.userType,
      userProfileURL: userProfileURL ?? this.userProfileURL,
    );
  }
}
