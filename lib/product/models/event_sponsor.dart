import 'dart:convert';

import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/base/base_institution.dart';
import 'package:deu_cis/product/models/image_asset.dart';
import 'package:deu_cis/product/models/mini/user_mini.dart';
import 'package:flutter/foundation.dart';

class EventSponsor extends BaseInstitution {
  late int sponsorPower;
  String? title;
  EventSponsor(
      {required super.id,
      required super.eventId,
      required super.institutionId,
      required super.name,
      required super.address,
      required super.slogan,
      required super.webPage,
      required super.description,
      required super.primaryContactUserId,
      required super.images,
      required super.primaryContactUser,
      required super.historys,
      required this.sponsorPower,
      required this.title});

  EventSponsor.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['event_id'];
    institutionId = json['institution_id'];
    name = json['name'];
    address = json['address'];
    slogan = json['slogan'];
    webPage = json['web_page'];
    description = json['description'];
    sponsorPower = json['sponsor_power'];
    title = json['title'];
    primaryContactUserId = json['primary_contact_user_id'];
    if (json['images'] != null) {
      images = <ImageAsset>[];
      json['images'].forEach((v) {
        images!.add(new ImageAsset.fromJson(v));
      });
    }
    if (json['primary_contact_user'] != null) {
      primaryContactUser = UserMini.fromJson(json['primary_contact_user']);
    }
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_id'] = this.eventId;
    data['institution_id'] = this.institutionId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['slogan'] = this.slogan;
    data['web_page'] = this.webPage;
    data['description'] = this.description;
    data['sponsor_power'] = this.sponsorPower;
    data['title'] = this.title;
    data['primary_contact_user_id'] = this.primaryContactUserId;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.primaryContactUser != null) {
      data['primary_contact_user'] = this.primaryContactUser;
    }
    return data;
  }

  String toJson() => json.encode(toMap());

  factory EventSponsor.fromJson(String source) =>
      EventSponsor.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
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
