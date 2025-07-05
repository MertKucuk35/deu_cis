import 'package:deu_cis/feature/event_session/event_session_view.dart';
import 'package:deu_cis/feature/public_profile/profile_detail_view.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/user_note_list_item.dart';
import 'package:deu_cis/product/enums/user_note_types.dart';
import 'package:deu_cis/product/models/user_notes.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/product/vm/user_note_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserNotesView extends StatefulWidget {
  const UserNotesView({super.key});

  @override
  State<UserNotesView> createState() => _UserNotesViewState();
}

class _UserNotesViewState extends State<UserNotesView> {
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup();
    _isLoading = false;
    setState(() {});
  }

  Future<void> _setup() async {
    await locator<UserNoteViewModel>()
        .fetchUserNotes(locator<AuthViewModel>().user!.id);
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
            appBar: AppBar(),
            body: ChangeNotifierProvider.value(
                value: locator<UserNoteViewModel>(),
                child: Consumer<UserNoteViewModel>(
                    builder: (context, userNoteViewModel, child) {
                  return ListView.builder(
                    itemCount: userNoteViewModel.userNotes?.length ?? 0,
                    itemBuilder: (context, index) {
                      return UserNotesListItem(
                        userNote: userNoteViewModel.userNotes![index],
                        function: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              String? noteType =
                                  userNoteViewModel.userNotes![index].noteType;
                              if (noteType == UserNoteTypes.person.name) {
                                return ProfileDetailView(
                                    profileID: (userNoteViewModel
                                            .userNotes![index]
                                            .meta as PersonMeta)
                                        .personId!);
                              } else if (noteType ==
                                  UserNoteTypes.event_session.name) {
                                return EventSessionView(
                                    eventSessionID: (userNoteViewModel
                                            .userNotes![index]
                                            .meta as EventSessionMeta)
                                        .sessionId!);
                              } else {
                                return SizedBox();
                              }
                            },
                          ));
                        },
                      );
                    },
                  );
                })));
  }
}
