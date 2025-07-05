import 'package:deu_cis/feature/event_detail/subview/subview/institution_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/base/base_institution.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_attende.dart';
import 'package:deu_cis/product/models/event_sponsor.dart';
import 'package:deu_cis/product/utility/month_helper.dart';
import 'package:deu_cis/product/vm/event_institution_view_model.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EventInstitutionsListItem extends StatelessWidget {
  EventInstitutionsListItem({
    super.key,
    required this.eventInstitution,
    // this.function,
  });

  final BaseInstitution eventInstitution;
  // final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.white,
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          eventInstitution is EventSponsor
              ? Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  color: AppColors.blueLight,
                  child: Text(
                    (eventInstitution as EventSponsor).title ?? '',
                    style: AppTextStyles.titleTextWhite,
                  ),
                )
              : SizedBox(),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.white,
              ),
              child: Column(
                children: [
                  Center(
                    child: CachedImage(
                      imageUrl:
                          eventInstitution.getImageURL(ImageAssetType.logo),
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.4,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      eventInstitution.name ?? '',
                      style: AppTextStyles.titleTextBlack,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      eventInstitution.slogan ?? '',
                      style: AppTextStyles.textFieldTextGrey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.themeColor,
                          shape: RoundedRectangleBorder(),
                        ),
                        onPressed: () {
                          locator<EventInstitutionViewModel>()
                              .selectInstitution(eventInstitution);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return InstitutionView(
                                institution:
                                    locator<EventInstitutionViewModel>()
                                        .selectedInstitution!,
                              );
                            },
                          ));
                        },
                        child: Text(StringConsts.infBtnMoreInfo,
                            style: AppTextStyles.buttonText)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
