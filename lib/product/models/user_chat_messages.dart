import 'dart:convert';

class UserChatMessages {
  int? id;
  int? ownerUserId;
  int? receiverUserId;
  String? message;
  DateTime? uploadAt;
  int? isRead;
  String? messageType;

  UserChatMessages(
      {this.id,
      this.ownerUserId,
      this.receiverUserId,
      this.message,
      this.uploadAt,
      this.isRead,
      this.messageType});

  UserChatMessages.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    ownerUserId = json['owner_user_id'];
    receiverUserId = json['receiver_user_id'];
    message = json['message'];
    uploadAt = DateTime.tryParse(json['upload_at'] as String);
    isRead = json['is_read'];
    messageType = json['message_type'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_user_id'] = this.ownerUserId;
    data['receiver_user_id'] = this.receiverUserId;
    data['message'] = this.message;
    data['upload_at'] = this.uploadAt;
    data['is_read'] = this.isRead;
    data['message_type'] = this.messageType;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory UserChatMessages.fromJson(String source) =>
      UserChatMessages.fromMap(json.decode(source) as Map<String, dynamic>);
}
