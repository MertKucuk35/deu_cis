import 'package:deu_cis/feature/event_detail/subview/subview/event_session_report_view.dart';
import 'package:flutter/material.dart';

class EventSessionReportsListView extends StatelessWidget {
  const EventSessionReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return EventSessionReportView();
                },
              ));
            },
            title: Text('Oturum Değerlendirmeleri'),
          )
        ],
      ),
    );
  }
}
