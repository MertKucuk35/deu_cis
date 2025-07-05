import 'package:deu_cis/feature/home/subview/draweritems/usernotes/user_note_detail_view.dart';
import 'package:deu_cis/feature/public_profile/profile_detail_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/public_profile.dart';
import 'package:deu_cis/product/services/model_service/event_session_service.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/product/vm/user_agenda_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventSessionView extends StatefulWidget {
  EventSessionView({super.key, required this.eventSessionID});
  int eventSessionID;

  @override
  State<EventSessionView> createState() => _EventSessionViewState();
}

class _EventSessionViewState extends State<EventSessionView> {
  BaseEventSession? _eventSession;
  late IEventSessionService _eventSessionService;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _setup();
  }

  Future<void> _setup() async {
    _eventSessionService = EventSessionService();
    _eventSession = await _eventSessionService.getEventSession(
        widget.eventSessionID, locator<AuthViewModel>().user!.id);
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
        : (_eventSession != null
            ? Scaffold(
                appBar: AppBar(
                  title: Text(
                    _eventSession!.title ?? '',
                    style: AppTextStyles.titleTextWhite,
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView(
                    children: [
                      Text(_eventSession!.title ?? '',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.titleTextBlack),
                      Text(
                        textAlign: TextAlign.center,
                        '${_eventSession?.startDate != null ? DateFormat('dd.mm.yyyy').format(_eventSession!.startDate!.toLocal()) : ''}, saat ${_eventSession?.startDate != null ? DateFormat('HH:mm').format(_eventSession!.startDate!.toLocal()) : ''} - ${_eventSession?.endDate != null ? DateFormat('HH:mm').format(_eventSession!.endDate!.toLocal()) : ''}',
                        style: AppTextStyles.textFieldTextGrey,
                      ),
                      Text(
                        _eventSession?.location ?? '',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textFieldTextBoldGrey,
                      ),
                      if (_eventSession!.startDate!.compareTo(DateTime.now()) >
                          0)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5))),
                                backgroundColor: MaterialStateProperty.all(
                                    AppColors.themeColor)),
                            onPressed: () {},
                            label: Text(
                              _eventSession!.startDate!
                                              .compareTo(DateTime.now()) >
                                          0 &&
                                      locator<UserAgendaViewModel>()
                                              .searchEventSessionInAgenda(
                                                  _eventSession!.id!) ==
                                          null
                                  ? StringConsts.addAgenda
                                  : StringConsts.removeAgenda,
                              style: TextStyle(color: AppColors.white),
                            ),
                            icon: Icon(
                                _eventSession!.startDate!
                                                .compareTo(DateTime.now()) >
                                            0 &&
                                        locator<UserAgendaViewModel>()
                                                .searchEventSessionInAgenda(
                                                    _eventSession!.id!) ==
                                            null
                                    ? Icons.add_circle
                                    : Icons.remove_circle,
                                color: AppColors.white),
                          ),
                        ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.05,
                        color: AppColors.greyLight,
                        child: Text(
                          StringConsts.eventSessionDesc,
                          style: TextStyle(
                            color: AppColors.textFieldTextColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.white,
                        child: Text(
                          _eventSession?.description ?? '',
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
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
                      _eventSession?.userNote != null
                          ? Container(
                              color: AppColors.white,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      _eventSession!.userNote!.noteText!,
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
                                                  userNote:
                                                      _eventSession!.userNote);
                                            },
                                          ));
                                        },
                                        icon: Icon(Icons.edit),
                                        color: AppColors.themeColor,
                                      ))
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {},
                              child: Container(
                                color: AppColors.white,
                                width: MediaQuery.of(context).size.width,
                                child: TextButton.icon(
                                    icon: Icon(
                                      Icons.note_alt,
                                      color: AppColors.blueLight,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) {
                                          return UserNoteDetailView(
                                              userNote:
                                                  _eventSession!.userNote);
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
                            ),
                      if (_eventSession?.speaker != null &&
                          _eventSession!.speaker!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.05,
                          color: AppColors.greyLight,
                          child: Text(
                            (_eventSession?.speaker?.length == 1)
                                ? StringConsts.speaker
                                : StringConsts.speakers,
                            style: TextStyle(
                              color: AppColors.textFieldTextColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      if (_eventSession?.speaker != null &&
                          _eventSession!.speaker!.isNotEmpty)
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: ListView.builder(
                            itemCount: _eventSession!.speaker!.length ?? 0,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Container(
                                color: AppColors.white,
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) {
                                        return ProfileDetailView(
                                          profileID: _eventSession!
                                              .speaker![index].speakerId!,
                                        );
                                      },
                                    ));
                                  },
                                  leading: CachedImage(
                                    isProfile: true,
                                    imageUrl: _eventSession!.speaker![index]
                                        .getImageURL(),
                                    width: 48,
                                    height: 48,
                                  ),
                                  title: Text(
                                      '${_eventSession!.speaker![index].title ?? ''} ${_eventSession!.speaker![index].firstName ?? ''} ${_eventSession!.speaker![index].lastName ?? ''}'),
                                  subtitle:
                                      _eventSession?.speaker?[index].position !=
                                                  null ||
                                              _eventSession?.speaker?[index]
                                                      .institutionName !=
                                                  null
                                          ? Text(
                                              (_eventSession!.speaker![index]
                                                          .position ??
                                                      '') +
                                                  '\n' +
                                                  (_eventSession!
                                                          .speaker![index]
                                                          .institutionName ??
                                                      ''),
                                            )
                                          : null,
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
                ),
              )
            : Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Text(StringConsts.notEventSession),
                ),
              ));
  }
}
