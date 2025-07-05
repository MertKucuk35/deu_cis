import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/historys.dart';
import 'package:deu_cis/product/models/image_asset.dart';
import 'package:deu_cis/product/models/mini/user_mini.dart';

abstract class BaseInstitution {
  int? id;
  int? eventId;
  int? institutionId;
  String? name;
  String? address;
  String? slogan;
  String? webPage;
  String? description;
  int? primaryContactUserId;
  List<ImageAsset>? images;
  UserMini? primaryContactUser;
  Historys? historys;

  BaseInstitution(
      {this.id,
      this.eventId,
      this.institutionId,
      this.name,
      this.address,
      this.slogan,
      this.webPage,
      this.description,
      this.primaryContactUserId,
      this.images,
      this.primaryContactUser,
      this.historys});

  String? getImageURL(ImageAssetType type);
}
