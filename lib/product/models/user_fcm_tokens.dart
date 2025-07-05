import 'dart:convert';

class UserFcmTokens {
  int? id;
  int? userId;
  String? mobileFcmToken;
  String? webFcmToken;

  UserFcmTokens({this.id, this.userId, this.mobileFcmToken, this.webFcmToken});

  UserFcmTokens.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    mobileFcmToken = json['mobile_fcm_token'];
    webFcmToken = json['web_fcm_token'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['mobile_fcm_token'] = this.mobileFcmToken;
    data['web_fcm_token'] = this.webFcmToken;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory UserFcmTokens.fromJson(String source) =>
      UserFcmTokens.fromMap(json.decode(source) as Map<String, dynamic>);
}
