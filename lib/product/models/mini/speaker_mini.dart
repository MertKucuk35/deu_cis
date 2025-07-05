import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:flutter/foundation.dart';

class SpeakerMini {
  int? speakerId;
  String? title;
  String? firstName;
  String? lastName;
  String? proilfeImageUrl;
  String? institutionName;
  String? position;

  SpeakerMini({this.speakerId, this.firstName, this.lastName});

  SpeakerMini.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    speakerId = json['speaker_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    proilfeImageUrl = json['photo_url'];
    institutionName = json['institution_name'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['speaker_id'] = this.speakerId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['photo_url'] = this.proilfeImageUrl;
    data['institution_name'] = this.institutionName;
    data['position'] = this.position;
    return data;
  }

  String? getImageURL() {
    if (proilfeImageUrl == null) return null;

    return kIsWeb
        ? proilfeImageUrl!.replaceAll('localhost', '192.168.1.7:58507')
        : proilfeImageUrl!.replaceAll('localhost', '10.0.2.2');
  }
}
