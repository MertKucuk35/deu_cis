import 'package:flutter/material.dart';

class EventHistoryView extends StatefulWidget {
  const EventHistoryView({super.key});

  @override
  State<EventHistoryView> createState() => _EventHistoryViewState();
}

class _EventHistoryViewState extends State<EventHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('History'),
      ),
    );
  }
}
