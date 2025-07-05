import 'package:deu_cis/feature/chat/chat_view.dart';
import 'package:deu_cis/feature/event_session/event_session_view.dart';
import 'package:deu_cis/feature/home/subview/draweritems/usernotes/user_note_detail_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/common/widget/title_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/enums/event_roles.dart';

import 'package:deu_cis/product/models/event_attende.dart';
import 'package:deu_cis/product/models/public_profile.dart';
import 'package:deu_cis/product/services/model_service/user_service.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileDetailView extends StatefulWidget {
  ProfileDetailView({
    required this.profileID,
    super.key,
  });
  int profileID;

  @override
  State<ProfileDetailView> createState() => _ProfileDetailViewState();
}

class _ProfileDetailViewState extends State<ProfileDetailView> {
  late IUserService _userService;
  late PublicProfile _profile;
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _setup();
  }

  Future<void> _setup() async {
    _userService = UserService();
    _profile = await _userService.getPublicProfile(
      locator<AuthViewModel>().user?.id ?? 0,
      widget.profileID,
    ) as PublicProfile;
    _isLoading = false;
    setState(() {});
  }

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
                "${_profile.title ?? ''} ${_profile.firstName} ${_profile.lastName}",
                style: AppTextStyles.titleTextWhite,
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            backgroundColor: AppColors.greyLight,
            body: ListView(
              children: [
                Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        foregroundDecoration: BoxDecoration(
                          color: AppColors.textFieldTextColor.withOpacity(0.25),
                          backgroundBlendMode: BlendMode.multiply,
                        ),
                        decoration: BoxDecoration(
                            backgroundBlendMode: BlendMode.multiply,
                            gradient: LinearGradient(colors: [
                              AppColors.gradientFirst,
                              AppColors.gradientSecond,
                              AppColors.gradientThird
                            ])),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.white,
                                                width: 1),
                                            shape: BoxShape.circle),
                                        child: CachedImage(
                                          width: 100,
                                          height: 100,
                                          isProfile: true,
                                          imageUrl: _profile.getImageURL(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      if (_profile.isPrimaryContact())
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryColor),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 2, 10, 2),
                                            child: Text(
                                              StringConsts
                                                      .primaryContactInProfile ??
                                                  '',
                                              style: AppTextStyles
                                                  .textFieldTextWhite,
                                            ),
                                          ),
                                        ),
                                      if (_profile.isSpeaker())
                                        Container(
                                          decoration: BoxDecoration(
                                              color: AppColors.blue),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 2, 10, 2),
                                            child: Text(
                                              StringConsts.speaker ?? '',
                                              style: AppTextStyles
                                                  .textFieldTextWhite,
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${_profile.firstName} ${_profile.lastName}",
                                        style: AppTextStyles.titleTextWhite,
                                      ),
                                      Text(
                                        (_profile.affillations?.firstOrNull
                                                    ?.position ??
                                                '') +
                                            '\n' +
                                            (_profile.affillations?.firstOrNull
                                                    ?.institutionName ??
                                                ''),
                                        style: AppTextStyles.subTitleTextWhite,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.star_border_outlined,
                                  color: AppColors.white,
                                )),
                            IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ChatView(
                                          userID:
                                              locator<AuthViewModel>().user!.id,
                                          reciverProfile: _profile,
                                        );
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Icons.chat_bubble_outline,
                                    color: AppColors.white)),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.mail_outline,
                                    color: AppColors.white))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.05,
                    color: AppColors.greyLight,
                    child: Text(
                      StringConsts.personelNotes,
                      style: TextStyle(
                        color: AppColors.textFieldTextColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                _profile.userNote != null
                    ? Container(
                        color: AppColors.white,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                _profile.userNote!.noteText!,
                              ),
                            ),
                            Container(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return UserNoteDetailView(
                                            userNote: _profile.userNote);
                                        ;
                                      },
                                    ));
                                  },
                                  icon: Icon(Icons.edit),
                                  color: AppColors.themeColor,
                                ))
                          ],
                        ),
                      )
                    : Container(
                        color: AppColors.white,
                        width: MediaQuery.of(context).size.width,
                        child: TextButton.icon(
                            icon: Icon(
                              Icons.note_alt,
                              color: AppColors.blueLight,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return UserNoteDetailView(
                                      userNote: _profile.userNote);
                                },
                              ));
                            },
                            label: Text(
                              StringConsts.personelNotesTake,
                              style: TextStyle(
                                color: AppColors.blueLight,
                              ),
                            )),
                      ),
                if (_profile.speakEvent != null &&
                    _profile.speakEvent!.isNotEmpty)
                  _speakHistory(profile: _profile),
                if (_profile.bioText != null)
                  Center(
                    child: Container(
                      color: AppColors.white,
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.05,
                            color: AppColors.greyLight,
                            child: Text(
                              StringConsts.about,
                              style: TextStyle(
                                color: AppColors.textFieldTextColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(StringConsts.bio,
                                style: AppTextStyles.subTitleTextBlack),
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(_profile.bioText!))
                        ],
                      ),
                    ),
                  ),
                if (_profile.affillations != null &&
                    _profile.affillations!.isNotEmpty)
                  _affilationsHistory(profile: _profile),
                if (_profile.education != null &&
                    _profile.education!.isNotEmpty)
                  _educationHistory(profile: _profile),
              ],
            ),
          );
  }
}

class _affilationsHistory extends StatelessWidget {
  const _affilationsHistory({
    super.key,
    required PublicProfile profile,
  }) : _profile = profile;

  final PublicProfile _profile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            color: AppColors.greyLight,
            child: Text(
              StringConsts.workHistory,
              style: TextStyle(
                color: AppColors.textFieldTextColor,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              itemCount: _profile.education?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(Icons.business),
                    title:
                        Text(_profile.education?[index].universityName ?? ''),
                    subtitle: Text(
                      '${_profile.affillations?[index].institutionName ?? ''},${_profile.affillations?[index].position ?? ''}\n'
                      '${_profile.affillations?[index].startDate != null ? DateFormat('yyyy').format(_profile.affillations![index].startDate!.toLocal()) : ''} - '
                      '${_profile.affillations?[index].endDate != null ? DateFormat('yyyy').format(_profile.affillations![index].endDate!.toLocal()) : StringConsts.continueEdc}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        // Navigate to event detail or speaker detail
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _educationHistory extends StatelessWidget {
  const _educationHistory({
    super.key,
    required PublicProfile profile,
  }) : _profile = profile;

  final PublicProfile _profile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            color: AppColors.greyLight,
            child: Text(
              StringConsts.educationHistory,
              style: TextStyle(
                color: AppColors.textFieldTextColor,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              itemCount: _profile.education?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Icon(Icons.school),
                    title:
                        Text(_profile.education?[index].universityName ?? ''),
                    subtitle: Text(
                      '${_profile.education?[index].degree ?? ''},${_profile.education?[index].department ?? ''}\n'
                      '${_profile.education?[index].startDate != null ? DateFormat('yyyy').format(_profile.education![index].startDate!.toLocal()) : ''} - '
                      '${_profile.education?[index].endDate != null ? DateFormat('yyyy').format(_profile.education![index].endDate!.toLocal()) : StringConsts.continueEdc}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        // Navigate to event detail or speaker detail
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _speakHistory extends StatelessWidget {
  const _speakHistory({
    super.key,
    required PublicProfile profile,
  }) : _profile = profile;

  final PublicProfile _profile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.05,
            color: AppColors.greyLight,
            child: Text(
              StringConsts.eventSpeak,
              style: TextStyle(
                color: AppColors.textFieldTextColor,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: ListView.builder(
              itemCount: _profile.speakEvent?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  color: AppColors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return EventSessionView(
                              eventSessionID:
                                  _profile.speakEvent![index].sessionID!);
                        },
                      ));
                    },
                    leading: Text(
                      '${_profile.speakEvent?[index].startDate != null ? DateFormat('HH:mm').format(_profile.speakEvent![index].startDate!.toLocal()) : ''} \n'
                      '${_profile.speakEvent?[index].endDate != null ? DateFormat('HH:mm').format(_profile.speakEvent![index].endDate!.toLocal()) : ''}',
                    ),
                    title: Text(_profile.speakEvent?[index].title ?? ''),
                    subtitle: Text(
                      (_profile.speakEvent?[index].location ?? '') +
                          '\n' +
                          (_profile.speakEvent![index].startDate != null
                              ? DateFormat('dd/mm/yyyy').format(_profile
                                  .speakEvent![index].startDate!
                                  .toLocal())
                              : ''),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        // Navigate to event detail or speaker detail
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
