import 'dart:convert';

import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/image_asset.dart';
import 'package:flutter/foundation.dart';

class Event {
  int? id;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? categoryName;
  String? locationName;
  String? latitude;
  String? longitude;
  List<ImageAsset>? images;

  Event(
      {this.id,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.categoryName,
      this.locationName,
      this.latitude,
      this.longitude,
      this.images});

  Event.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    startDate = DateTime.tryParse(json['start_date'] as String);
    endDate = DateTime.tryParse(json['end_date'] as String);
    categoryName = json['category_name'];
    locationName = json['location_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['images'] != null) {
      images = <ImageAsset>[];
      json['images'].forEach((v) {
        images!.add(new ImageAsset.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['category_name'] = this.categoryName;
    data['location_name'] = this.locationName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  String toJson() => json.encode(toMap());

  factory Event.fromJson(String source) =>
      Event.fromMap(json.decode(source) as Map<String, dynamic>);

  String? getImageURL(ImageAssetType type) {
    if (images == null) return null;
    for (int i = 0; i < images!.length; i++) {
      if (images![i].assetType == type.name) {
        return kIsWeb
            ? images![i].assetUrl?.replaceAll('localhost', '192.168.1.7:58507')
            : images![i].assetUrl?.replaceAll('localhost', '10.0.2.2');
      }
    }
    return null;
  }
}
