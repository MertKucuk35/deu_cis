import 'package:deu_cis/feature/home/subview/agenda/user_agenda_view.dart';
import 'package:deu_cis/feature/home/subview/events/event_view_model.dart';
import 'package:deu_cis/feature/home/subview/qr_scan/qr_view.dart';
import 'package:deu_cis/product/common/widget/cached_image.dart';
import 'package:deu_cis/product/vm/user_agenda_view_model.dart';
import 'package:deu_cis/feature/home/subview/events/events_list_view.dart';
import 'package:deu_cis/product/vm/auth_view_model.dart';
import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/model/tab_item.dart';
import 'package:deu_cis/product/constants/index.dart';
import 'package:flutter/material.dart';

class HomewView extends StatefulWidget {
  const HomewView({super.key});

  @override
  State<HomewView> createState() => _HomewViewState();
}

class _HomewViewState extends State<HomewView> {
  bool isSearch = false;
  bool _isLoading = true;
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
    await locator<EventViewModel>().fetchEvents();
    await locator<UserAgendaViewModel>()
        .fetchUserAgenda(locator<AuthViewModel>().user!.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            drawer: Drawer(
              child: Column(
                children: [
                  _drawerHeader(),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return QRView();
                        },
                      ));
                    },
                    leading: Icon(Icons.qr_code),
                    title: Text(StringConsts.qrCode),
                  )
                ],
              ),
            ),
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

class _drawerHeader extends StatelessWidget {
  const _drawerHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.gradientFirst,
          AppColors.gradientSecond,
          AppColors.gradientThird
        ]),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Foreground semi-transparent overlay
          Container(
            decoration: BoxDecoration(
              color: AppColors.black.withOpacity(0.3),
            ),
          ),
          // Text stays above the overlay
          Row(
            children: [
              SizedBox(
                width: 30,
              ),
              CachedImage(
                isProfile: true,
                imageUrl: locator<AuthViewModel>().user!.getImageURL(),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locator<AuthViewModel>().user!.firstName +
                        ' ' +
                        locator<AuthViewModel>().user!.lastName,
                    style: AppTextStyles.titleTextWhite,
                  ),
                  Row(
                    spacing: 5,
                    children: [
                      Icon(
                        size: 14,
                        Icons.edit,
                        color: AppColors.greyLight,
                      ),
                      Text(
                        StringConsts.editProfile,
                        style: AppTextStyles.textFieldTextLightGrey,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
