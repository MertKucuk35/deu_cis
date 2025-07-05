class AffillationsMini {
  int? id;
  String? institutionName;
  String? position;

  int? listIndex;

  AffillationsMini(
      {this.id, this.institutionName, this.position, this.listIndex});

  AffillationsMini.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    institutionName = json['institution_name'];
    position = json['position'];

    listIndex = json['list_index'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['institution_name'] = this.institutionName;
    data['position'] = this.position;

    data['list_index'] = this.listIndex;
    return data;
  }
}
