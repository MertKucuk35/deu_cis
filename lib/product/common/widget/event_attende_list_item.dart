import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_attende.dart';
import 'package:deu_cis/product/utility/month_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EventAttendeListItem extends StatelessWidget {
  EventAttendeListItem({
    super.key,
    required this.eventAttende,
    this.function,
  });

  final EventAttende eventAttende;
  final VoidCallback? function;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          color: AppColors.white,
          child: Container(
            padding: const EdgeInsets.all(8),
            color: AppColors.white,
            child: Row(
              children: [
                Column(
                  children: [
                    if (eventAttende.photoUrl != null)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        child: CachedImage(
                          isProfile: true,
                          imageUrl: eventAttende.getImageURL(),
                          width: 48,
                          height: 48,
                        ),
                      )
                    else
                      Icon(Icons.person, size: 48),
                    if (eventAttende.isSpeaker())
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 2),
                        color: AppColors.themeColor,
                        child: Text(
                          StringConsts.infBtnSpeaker,
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${eventAttende.title ?? ''} ${eventAttende.firstName ?? ''} ${eventAttende.lastName ?? ''}',
                        style: AppTextStyles.titleTextBlack,
                      ),
                      eventAttende.position != null
                          ? Text(
                              '${eventAttende.position ?? ''} \n${eventAttende.institutionName ?? ''}',
                              style: AppTextStyles.textFieldTextGrey,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right_outlined, color: AppColors.themeColor),
              ],
            ),
          )),
    );
  }
}
