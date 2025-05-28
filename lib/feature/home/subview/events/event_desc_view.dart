import 'package:deu_cis/feature/home/subview/events/event_detail/event_detail_view.dart';
import 'package:deu_cis/feature/home/subview/events/event_view_model.dart';

import 'package:deu_cis/product/common/widget/event_list_item.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/enums/image_constants.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

class EventDescriptionView extends StatelessWidget {
  EventDescriptionView({
    super.key,
  });

  Event event = locator<EventViewModel>().selectedEvent!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          event.title ?? '',
          style: TextStyle(
            color: AppColors.white,
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5))),
                backgroundColor:
                    MaterialStateProperty.all(AppColors.themeColor)),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return EventDetailView();
                },
              ));
            },
            child: Text(
              StringConsts.eventDescSee,
              style: TextStyle(color: AppColors.white),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ResponsiveBreakpoints.of(context).isMobile
                ? CachedImage(
                    imageUrl: event.getImageURL(ImageAssetType.background),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 0.4,
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Image.asset(ImageConstants.demoBg.toPng)),
            // CachedImage(
            //     imageUrl: event.getImageURL(ImageAssetType.background),
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.height * 0.4,
            //   ),
            EventListItem(
              imageNeed: true,
              event: event,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              color: AppColors.greyLight,
              width: MediaQuery.of(context).size.width,
              child: Text(StringConsts.eventDesc),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: Text(event.description ?? '')),
          ],
        ),
      ),
    );
  }
}
