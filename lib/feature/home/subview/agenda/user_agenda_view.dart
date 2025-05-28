import 'package:deu_cis/product/vm/user_agenda_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/agenda_list_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserAgendaView extends StatefulWidget {
  const UserAgendaView({super.key});

  @override
  State<UserAgendaView> createState() => _UserAgendaViewState();
}

class _UserAgendaViewState extends State<UserAgendaView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      body: ChangeNotifierProvider.value(
          value: locator<UserAgendaViewModel>(),
          child: Consumer<UserAgendaViewModel>(
              builder: (context, eventAgendaViewModel, child) {
            return ListView.builder(
              itemCount: eventAgendaViewModel.userAgendaList?.length ?? 0,
              itemBuilder: (context, index) {
                return UserAgendaListItem(
                  onTapFunction: () {},
                  trialingFunction: () async {
                    await eventAgendaViewModel.deleteUserAgendaItem(index);
                    // setState(() {});
                  },
                  userAgendaSession:
                      eventAgendaViewModel.userAgendaList?[index],
                );
              },
            );
          })),
    );
  }
}
