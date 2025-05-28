import 'package:deu_cis/product/models/speaker_mini.dart';

abstract class BaseEventSession {
  int? id;
  int? eventId;
  DateTime? startDate;
  DateTime? endDate;
  String? title;
  String? description;
  String? location;
  List<SpeakerMini>? speaker;

  BaseEventSession(
      {this.id,
      this.eventId,
      this.startDate,
      this.endDate,
      this.title,
      this.description,
      this.location,
      this.speaker});
}
