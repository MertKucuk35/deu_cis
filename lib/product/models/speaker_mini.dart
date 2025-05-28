class SpeakerMini {
  int? speakerId;
  String? firstName;
  String? lastName;

  SpeakerMini({this.speakerId, this.firstName, this.lastName});

  SpeakerMini.fromJson(Map<String, dynamic> json) {
    speakerId = json['speaker_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speaker_id'] = this.speakerId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}
