import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/utility/month_helper.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EventListItem extends StatelessWidget {
  EventListItem({
    super.key,
    required this.event,
    this.function,
    this.icon,
    required this.imageNeed,
  });

  final Event event;
  final VoidCallback? function;
  Icon? icon;
  bool imageNeed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        color: AppColors.white,
        child: ListTile(
          leading: imageNeed
              ? (event.getImageURL(ImageAssetType.logo) != null
                  ? CachedImage(
                      imageUrl: event.getImageURL(ImageAssetType.logo),
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
                          Icons.event,
                          size: ResponsiveBreakpoints.of(context).isMobile
                              ? MediaQuery.of(context).size.width * 0.2
                              : MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                    ))
              : null,
          title: Text(
            event.title ?? '',
            style: AppTextStyles.titleTextBlack,
          ),
          subtitle: Text(
            '${event.startDate != null ? (MonthHelper.getMonth(event.startDate!.month) ?? '') + ' ' + event.startDate!.day.toString() : ''} - '
            '${event.endDate != null ? (MonthHelper.getMonth(event.endDate!.month) ?? '') + ' ' + event.endDate!.day.toString() : ''}\n'
            '${event.locationName ?? ''}',
          ),
          trailing: icon != null ? icon! : null,
        ),
      ),
    );
  }
}
