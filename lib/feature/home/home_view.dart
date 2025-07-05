import 'package:deu_cis/feature/home/subview/agenda/user_agenda_view.dart';
import 'package:deu_cis/product/models/user_fcm_tokens.dart';
import 'package:deu_cis/product/services/firebase/firebase_messaging_service.dart';
import 'package:deu_cis/product/services/model_service/user_fcm_tokens_service.dart';

import 'package:deu_cis/product/vm/event_view_model.dart';

import 'package:deu_cis/feature/home/widget/drawer_widget.dart';

import 'package:deu_cis/product/vm/user_agenda_view_model.dart';
import 'package:deu_cis/feature/home/subview/events/events_list_view.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/model/tab_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isSearch = false;
  bool _isLoading = true;
  UserFcmTokens? _userFcmTokens;
  IUserFcmTokensService? _userFcmTokensService;
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  final List<TabItem> _tabs = [
    TabItem(title: StringConsts.events, child: EventsListView()),
    TabItem(title: StringConsts.myAgenda, child: UserAgendaView()),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    _userFcmTokensService = UserFcmTokensService();
    await locator<EventViewModel>().fetchEvents();
    await locator<UserAgendaViewModel>()
        .fetchUserAgenda(locator<AuthViewModel>().user!.id);

    setState(() {
      _isLoading = false;
    });
    await _fcmTokenControll();
  }

  Future<void> _fcmTokenControll() async {
    await FirebaseNotificationService.requestForPermision();
    _userFcmTokens = await _userFcmTokensService!
        .getUserFcmTokens(locator<AuthViewModel>().user!.id);

    if (_userFcmTokens == null) {
      _userFcmTokens =
          await _userFcmTokensService?.addUserFcmTokens(UserFcmTokens(
        userId: locator<AuthViewModel>().user!.id,
        mobileFcmToken:
            kIsWeb ? null : await FirebaseNotificationService.getFCMToken(),
        webFcmToken:
            kIsWeb ? await FirebaseNotificationService.getFCMToken() : null,
      ));
    } else {
      UserFcmTokens nowTokens = UserFcmTokens(
        userId: locator<AuthViewModel>().user!.id,
        mobileFcmToken:
            kIsWeb ? null : await FirebaseNotificationService.getFCMToken(),
        webFcmToken:
            kIsWeb ? await FirebaseNotificationService.getFCMToken() : null,
      );

      if (nowTokens.mobileFcmToken != _userFcmTokens!.mobileFcmToken ||
          nowTokens.webFcmToken != _userFcmTokens!.webFcmToken) {
        _userFcmTokens =
            await _userFcmTokensService!.updateUserFcmTokens(nowTokens);
      }
    }
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
            drawer: DrawerWidget(),
            appBar: AppBar(
              title: isSearch
                  ? TextField(
                      controller: searchController,
                      focusNode: searchFocusNode,
                      style: AppTextStyles.textFieldTextWhite,
                    )
                  : Text(
                      StringConsts.home,
                      style: TextStyle(color: AppColors.white),
                    ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        isSearch = !isSearch;
                        searchController.clear();
                        searchFocusNode.requestFocus();
                      });
                    },
                    icon: isSearch ? Icon(Icons.close) : Icon(Icons.search)),
                IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
              ],
            ),
            body: SafeArea(
              child: DefaultTabController(
                length: _tabs.length,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TabBar(
                        tabs: _tabs
                            .map((tab) => Tab(
                                  text: tab.title,
                                ))
                            .toList(),
                      ),
                    ),
                    Expanded(
                        flex: 13,
                        child: TabBarView(
                            children: _tabs.map((tab) => tab.child).toList())),
                  ],
                ),
              ),
            ),
          );
  }
}
