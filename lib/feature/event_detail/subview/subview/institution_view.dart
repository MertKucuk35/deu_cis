import 'package:deu_cis/feature/event_detail/subview/subview/widget/institutions_head.dart';
import 'package:deu_cis/feature/event_detail/subview/subview/widget/organizer_list_item.dart';
import 'package:deu_cis/feature/event_detail/subview/subview/widget/sponsor_list_item.dart';
import 'package:deu_cis/feature/public_profile/profile_detail_view.dart';
import 'package:deu_cis/feature/webview/web_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/title_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/base/base_institution.dart';
import 'package:deu_cis/product/models/historys.dart';
import 'package:deu_cis/product/services/model_service/event_institutions_service.dart';
import 'package:deu_cis/product/vm/event_institution_view_model.dart';
import 'package:flutter/material.dart';

class InstitutionView extends StatefulWidget {
  InstitutionView({super.key, required this.institution});
  BaseInstitution institution;

  @override
  State<InstitutionView> createState() => _InstitutionViewState();
}

class _InstitutionViewState extends State<InstitutionView> {
  late IEventInstitutionsService _eventInstitutionsService;
  bool _isLoading = true;
  late BaseInstitution institution;

  @override
  void initState() {
    super.initState();
    _eventInstitutionsService = EventInstitutionsService();

    Future.microtask(
      () {
        _setup(_eventInstitutionsService).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      },
    );
  }

  // BaseInstitution institution =
  //     locator<EventInstitutionViewModel>().selectedInstitution!;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                widget.institution.name!,
                style: AppTextStyles.titleTextWhite,
              ),
            ),
            backgroundColor: AppColors.greyLight,
            body: ListView(
              children: [
                InstitutionsHead(institution: widget.institution),
                TitleItemSmall(
                  title: StringConsts.institutionDescTitle,
                ),
                SizedBox(height: 5),
                Container(
                  color: AppColors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(widget.institution.description ?? ''),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                institution.historys?.sponsors != null &&
                        institution.historys!.sponsors!.isNotEmpty
                    ? Column(
                        children: [
                          TitleItemSmall(
                            title: StringConsts.institutionSponsors,
                          ),
                          SizedBox(height: 5),
                          Container(
                            color: AppColors.white,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return SponsorListItem(
                                    index: index,
                                    sponsors:
                                        institution.historys!.sponsors![index]);
                              },
                              itemCount: institution.historys!.sponsors!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 10),
                institution.historys?.organizers != null &&
                        institution.historys!.organizers!.isNotEmpty
                    ? Column(
                        children: [
                          TitleItemSmall(
                            title: StringConsts.institutionOrganizers,
                          ),
                          SizedBox(height: 5),
                          Container(
                            color: AppColors.white,
                            height: MediaQuery.of(context).size.height * 0.15,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return OrganizerListItem(
                                    index: index,
                                    organizers: institution
                                        .historys!.organizers![index]);
                              },
                              itemCount:
                                  institution.historys!.organizers!.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            ),
                          )
                        ],
                      )
                    : SizedBox(),
                SizedBox(height: 10),
                TitleItemSmall(
                  title: StringConsts.contactInfo,
                ),
                SizedBox(height: 5),
                Container(
                  color: AppColors.white,
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      widget.institution.webPage != null
                          ? Row(
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => WebView(
                                          webUrl: widget.institution.webPage!,
                                        ),
                                      ),
                                    );
                                  },
                                  label: Text(widget.institution.webPage!),
                                  icon: Icon(Icons.web),
                                )
                              ],
                            )
                          : SizedBox(),
                      Row(
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileDetailView(
                                    profileID: widget
                                        .institution.primaryContactUser!.id!,
                                  ),
                                ),
                              );
                            },
                            label: Text(
                              (StringConsts.primaryContact +
                                      (widget.institution.primaryContactUser
                                              ?.firstName ??
                                          '') +
                                      ' ' +
                                      (widget.institution.primaryContactUser
                                              ?.lastName ??
                                          ''))
                                  .trim(),
                            ),
                            icon: Icon(Icons.person),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }

  Future<void> _setup(
      IEventInstitutionsService _eventInstitutionsService) async {
    institution = widget.institution;
    institution.historys =
        await _eventInstitutionsService.getHistorys(widget.institution.id!);
  }
}
