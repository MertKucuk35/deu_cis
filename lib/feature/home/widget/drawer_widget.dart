import 'package:deu_cis/feature/home/subview/draweritems/contacs/contacs_view.dart';
import 'package:deu_cis/feature/home/subview/draweritems/eventhistory/event_history.dart';
import 'package:deu_cis/feature/home/subview/draweritems/qr_scan/qr_view.dart';
import 'package:deu_cis/feature/home/subview/draweritems/usernotes/user_notes_view.dart';
import 'package:deu_cis/feature/home/subview/draweritems/userprofile/profile_view.dart';
import 'package:deu_cis/feature/home/widget/drawer_header.dart';
import 'package:deu_cis/feature/home/widget/drawer_list_item.dart';
import 'package:deu_cis/product/constants/string_consts.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeaderWidget(),
          DrawerListItem(
              icon: Icon(Icons.qr_code),
              title: StringConsts.qrCode,
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return QRView();
                  },
                ));
              }),
          DrawerListItem(
              icon: Icon(Icons.person),
              title: StringConsts.myContacs,
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ContactsView();
                  },
                ));
              }),
          DrawerListItem(
              icon: Icon(Icons.note),
              title: StringConsts.myNotes,
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return UserNotesView();
                  },
                ));
              }),
          DrawerListItem(
              icon: Icon(Icons.history),
              title: StringConsts.eventHistory,
              function: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return EventHistoryView();
                  },
                ));
              }),
        ],
      ),
    );
  }
}
