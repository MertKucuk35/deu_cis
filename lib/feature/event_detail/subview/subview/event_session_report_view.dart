import 'package:deu_cis/locator.dart';
import 'package:deu_cis/product/common/widget/event_attende_list_item.dart';
import 'package:deu_cis/product/models/event_attende.dart';
import 'package:deu_cis/product/vm/event_session_istatistics_view_model.dart';
import 'package:deu_cis/product/vm/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventSessionReportView extends StatefulWidget {
  const EventSessionReportView({super.key});

  @override
  State<EventSessionReportView> createState() => _EventSessionReportViewState();
}

class _EventSessionReportViewState extends State<EventSessionReportView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _setup();
  }

  Future<void> _setup() async {
    await locator<EventSessionIstatisticsViewModel>()
        .fetchEventSessioRates(locator<EventViewModel>().selectedEvent!.id!)
        .then(
      (value) {
        _isLoading = false;
        setState(() {});
      },
    );
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
                value: locator<EventSessionIstatisticsViewModel>(),
                child: Consumer<EventSessionIstatisticsViewModel>(
                  builder: (context, eventSessionIstatisticsViewModel, child) {
                    return ListView.builder(
                        itemCount: eventSessionIstatisticsViewModel
                                .eventSessioRates?.length ??
                            0,
                        itemBuilder: (context, index) {
                          final sessionRate = eventSessionIstatisticsViewModel
                              .eventSessioRates![index];
                          return ExpansionTile(
                            title: Text(
                                '${index + 1}. ${sessionRate.sessionTitle ?? ''}'),
                            children: [
                              ListTile(
                                title: Text(
                                    'Oylayan Sayısı: ${sessionRate.totalVotes ?? 0}'),
                              ),
                              ListTile(
                                title: Text(
                                    'Katılımcı Sayısı: ${sessionRate.totalListAdditions ?? 0}'),
                              ),
                              ListTile(
                                title: Text(
                                    'Ortalama Puan: ${sessionRate.averageScore}'),
                              ),
                              ListTile(
                                title: Text(
                                    'Oylama Oranı: %${(sessionRate.totalListAdditions ?? 0) > 0 ? (((sessionRate.totalVotes ?? 0) / (sessionRate.totalListAdditions ?? 1)) * 100).toStringAsFixed(0) : 'N/A'}'),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: sessionRate.speakers?.length ?? 0,
                                itemBuilder: (context, speakerIndex) {
                                  return EventAttendeListItem(
                                    function: null,
                                    eventAttende: EventAttende(
                                      photoUrl: sessionRate
                                          .speakers![speakerIndex].photoUrl,
                                      userId: sessionRate
                                          .speakers![speakerIndex].userId,
                                      firstName: sessionRate
                                          .speakers![speakerIndex].fullName,
                                    ),
                                  );
                                },
                              )
                            ],
                          );
                        });
                  },
                )));
  }
}
