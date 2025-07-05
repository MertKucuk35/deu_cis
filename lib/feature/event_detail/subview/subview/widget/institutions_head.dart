import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/base/base_institution.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/utility/month_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class InstitutionsHead extends StatelessWidget {
  InstitutionsHead({
    super.key,
    required this.institution,
    this.icon,
  });

  final BaseInstitution institution;

  Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      color: AppColors.white,
      child: ListTile(
        leading: (institution.getImageURL(ImageAssetType.logo) != null
            ? CachedImage(
                imageUrl: institution.getImageURL(ImageAssetType.logo),
                width: MediaQuery.of(context).size.width * 0.2,
                height: ResponsiveBreakpoints.of(context).isMobile
                    ? MediaQuery.of(context).size.width * 0.2
                    : MediaQuery.of(context).size.height * 0.2,
                fit: BoxFit.fitWidth,
              )
            : Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  // width: MediaQuery.of(context).size.width * 0.2,
                  // height: MediaQuery.of(context).size.width * 0.2,
                  child: Icon(
                    Icons.corporate_fare,
                    size: ResponsiveBreakpoints.of(context).isMobile
                        ? MediaQuery.of(context).size.width * 0.2
                        : MediaQuery.of(context).size.height * 0.2,
                  ),
                ),
              )),
        title: Text(
          institution.name ?? '',
          style: AppTextStyles.titleTextBlack,
        ),
        subtitle: Text('${institution.slogan}'
            // '\n'
            // '${event.locationName ?? ''}',
            ),
        trailing: icon != null ? icon! : null,
      ),
    );
  }
}
