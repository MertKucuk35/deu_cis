class ImageAsset {
  int? id;
  String? assetType;
  String? assetUrl;

  ImageAsset({this.id, this.assetType, this.assetUrl});

  ImageAsset.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assetType = json['asset_type'];
    assetUrl = json['asset_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['asset_type'] = this.assetType;
    data['asset_url'] = this.assetUrl;
    return data;
  }
}
