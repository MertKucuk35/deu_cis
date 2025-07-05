import 'package:deu_cis/feature/event_detail/subview/subview/event_organizers_list_view.dart';
import 'package:deu_cis/feature/event_detail/subview/subview/event_session_reports_list_view.dart';
import 'package:deu_cis/feature/event_detail/subview/subview/event_speakers_view.dart';
import 'package:deu_cis/feature/event_detail/subview/subview/event_sponsors_list_view.dart';
import 'package:deu_cis/feature/event_detail/subview/subview/session_rating_list.dart';
import 'package:deu_cis/feature/event_detail/subview/widget/google_map_widget.dart';
import 'package:deu_cis/product/vm/event_view_model.dart';
import 'package:deu_cis/product/common/widget/image_zoom_dialog.dart';
import 'package:deu_cis/product/common/widget/title_item.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/common/widget/event_list_item.dart';
import 'package:deu_cis/product/constants/index.dart';

import 'package:deu_cis/product/enums/image_asset_types.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventHomeView extends StatefulWidget {
  const EventHomeView({super.key});

  @override
  State<EventHomeView> createState() => _EventHomeViewState();
}

class _EventHomeViewState extends State<EventHomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider.value(
          value: locator<EventViewModel>(),
          child: Consumer<EventViewModel>(
              builder: (context, eventViewModel, child) {
            return ListView(
              children: [
                Container(
                  child: Stack(
                    children: [
                      Positioned(
                        child: CachedImage(
                          imageUrl: locator<EventViewModel>()
                              .selectedEvent!
                              .getImageURL(ImageAssetType.background),
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Positioned(
                        left: 15,
                        child: Container(
                          color: AppColors.white,
                          child: CachedImage(
                            imageUrl: locator<EventViewModel>()
                                .selectedEvent!
                                .getImageURL(ImageAssetType.logo),
                            height: MediaQuery.of(context).size.width * 0.25,
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                EventListItem(
                  event: locator<EventViewModel>().selectedEvent!,
                  imageNeed: false,
                ),
                GoogleMapWidget(
                  event: locator<EventViewModel>().selectedEvent!,
                ),
                if (locator<AuthViewModel>().user!.isAdmin()) AdminTools(),
                _infoButtonsList(),
                _description()
              ],
            );
          })),
    );
  }
}

class _description extends StatelessWidget {
  const _description({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedEvent = locator<EventViewModel>().selectedEvent;
    if (selectedEvent != null && selectedEvent.description != null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
          color: AppColors.white,
          child: Column(
            children: [
              TitleItem(title: StringConsts.footerDescTitle),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(selectedEvent.description ?? ''),
              ),
            ],
          ),
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }
}

class _infoButtonsList extends StatelessWidget {
  const _infoButtonsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
          color: AppColors.white,
          child: Column(
            children: [
              TitleItem(title: StringConsts.infBtnListTitle),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 5,
                  children: [
                    _infoButtonListItem(
                      title: StringConsts.infBtnFloorPlan,
                      onTapFunction: locator<EventViewModel>()
                                  .selectedEvent!
                                  .getImageURL(ImageAssetType.floorplan) !=
                              null
                          ? () {
                              showDialog(
                                context: context,
                                builder: (context) => ImageZoomDialog(
                                    imageUrl: locator<EventViewModel>()
                                        .selectedEvent!
                                        .getImageURL(
                                            ImageAssetType.floorplan)!),
                              );
                            }
                          : null,
                    ),
                    _infoButtonListItem(
                      onTapFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EventSpeakersView();
                          },
                        ));
                      },
                      title: StringConsts.infBtnSpeakers,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 5,
                  children: [
                    _infoButtonListItem(
                      title: StringConsts.infBtnSponsors,
                      onTapFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EventSponsorsListView();
                          },
                        ));
                      },
                    ),
                    _infoButtonListItem(
                      title: StringConsts.infBtnOrganizer,
                      onTapFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return EventOrganizersListView();
                          },
                        ));
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 5,
                  children: [
                    _infoButtonListItem(
                      title: StringConsts.rating,
                      onTapFunction: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return SessionRatingList();
                          },
                        ));
                      },
                    ),
                    _infoButtonListItem(title: 'demo2'),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  spacing: 5,
                  children: [
                    _infoButtonListItem(
                      title: 'demo',
                    ),
                    _infoButtonListItem(title: 'demo2'),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class _infoButtonListItem extends StatelessWidget {
  const _infoButtonListItem({
    super.key,
    this.onTapFunction,
    required this.title,
  });
  final VoidCallback? onTapFunction;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          foregroundColor: Colors.black, // Yazı rengi siyah olsun
          side:
              BorderSide(color: Colors.grey.shade100), // İsteğe bağlı kenarlık
        ),
        onPressed: onTapFunction,
        child: Text(title),
      ),
    );
  }
}

class AdminTools extends StatelessWidget {
  const AdminTools({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
      child: Container(
        color: AppColors.white,
        child: Column(
          children: [
            TitleItem(title: StringConsts.adminTools),
            ListTile(
              leading: Icon(Icons.announcement),
              title: Text(StringConsts.adminAnnouncments),
              trailing: Icon(Icons.chevron_right_outlined),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return EventSessionReportsListView();
                  },
                ));
              },
              leading: Icon(Icons.report),
              title: Text(StringConsts.adminReport),
              trailing: Icon(Icons.chevron_right_outlined),
            )
          ],
        ),
      ),
    );
  }
}
