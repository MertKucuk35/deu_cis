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
        child: ListTile(
          leading: eventAttende.photoUrl != null
              ? (eventAttende.photoUrl != null
                  ? CachedImage(
                      isProfile: true,
                      imageUrl: eventAttende.getImageURL(),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: ResponsiveBreakpoints.of(context).isMobile
                          ? MediaQuery.of(context).size.width * 0.2
                          : MediaQuery.of(context).size.height * 0.2,
                    )
                  : Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        // width: MediaQuery.of(context).size.width * 0.2,
                        // height: MediaQuery.of(context).size.width * 0.2,
                        child: Icon(
                          Icons.person,
                          size: ResponsiveBreakpoints.of(context).isMobile
                              ? MediaQuery.of(context).size.width * 0.2
                              : MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                    ))
              : null,
          title: Text(
            '${eventAttende.firstName ?? ''} ${eventAttende.lastName ?? ''}',
            style: AppTextStyles.titleTextBlack,
          ),
          subtitle: eventAttende.isSpeaker()
              ? Text(StringConsts.infBtnSpeaker,
                  style: TextStyle(
                      color: AppColors.white,
                      backgroundColor: AppColors.themeColor))
              : null,
          trailing:
              Icon(Icons.chevron_right_outlined, color: AppColors.themeColor),
        ),
      ),
    );
  }
}
