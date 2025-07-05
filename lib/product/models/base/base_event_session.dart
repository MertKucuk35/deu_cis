import 'package:deu_cis/product/models/mini/speaker_mini.dart';
import 'package:deu_cis/product/models/user_notes.dart';

abstract class BaseEventSession {
  int? id;
  int? eventId;
  DateTime? startDate;
  DateTime? endDate;
  String? title;
  String? description;
  String? location;
  UserNote? userNote;
  List<SpeakerMini>? speaker;

  BaseEventSession(
      {this.id,
      this.eventId,
      this.startDate,
      this.endDate,
      this.title,
      this.description,
      this.location,
      this.speaker,
      this.userNote});
}
