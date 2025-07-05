import 'dart:convert';

class Historys {
  List<Sponsors>? sponsors;
  List<Organizers>? organizers;

  Historys({this.sponsors, this.organizers});

  Historys.fromMap(Map<String, dynamic> json) {
    if (json['sponsors'] != null) {
      sponsors = <Sponsors>[];
      json['sponsors'].forEach((v) {
        sponsors!.add(new Sponsors.fromJson(v));
      });
    }
    if (json['organizers'] != null) {
      organizers = <Organizers>[];
      json['organizers'].forEach((v) {
        organizers!.add(new Organizers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sponsors != null) {
      data['sponsors'] = this.sponsors!.map((v) => v.toJson()).toList();
    }
    if (this.organizers != null) {
      data['organizers'] = this.organizers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJson() => json.encode(toMap());

  factory Historys.fromJson(String source) =>
      Historys.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Sponsors {
  int? eventID;
  String? eventTitle;
  String? sponsorTitle;

  Sponsors({this.eventTitle, this.sponsorTitle});

  Sponsors.fromJson(Map<String, dynamic> json) {
    eventID = json['id'];
    eventTitle = json['eventTitle'];
    sponsorTitle = json['sponsorTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.eventID;
    data['eventTitle'] = this.eventTitle;
    data['sponsorTitle'] = this.sponsorTitle;
    return data;
  }
}

class Organizers {
  int? eventID;
  String? eventTitle;

  Organizers({this.eventTitle});

  Organizers.fromJson(Map<String, dynamic> json) {
    eventID = json['id'];
    eventTitle = json['eventTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.eventID;
    data['eventTitle'] = this.eventTitle;
    return data;
  }
}
