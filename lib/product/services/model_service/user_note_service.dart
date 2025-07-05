import 'dart:convert';

import 'package:deu_cis/product/enums/end_points.dart';
import 'package:deu_cis/product/exceptions/error_exceptions.dart';
import 'package:deu_cis/product/models/base/base_event_session.dart';
import 'package:deu_cis/product/models/event.dart';
import 'package:deu_cis/product/models/event_session.dart';
import 'package:deu_cis/product/models/user_agenda_session.dart';
import 'package:deu_cis/product/models/user_notes.dart';
import 'package:deu_cis/product/models/user_session_rate.dart';
import 'package:deu_cis/product/utility/http_helper.dart';

abstract class IUserNoteService {
  // Future<List<EventSession>?> getUserSessionRating(int eventID, int userID);
  Future<List<UserNote>?> getUserNotes(int userID);
  // Future<List<UserAgendaSession>?> getUserAgenda(int userID);
  Future<UserNote?> addUserNote(UserNote userNote);
  Future<UserNote?> updateUserNote(UserNote userNote);
  Future<void> deleteUserNote(UserNote userNote);
}

class UserNoteService implements IUserNoteService {
  @override
  Future<List<UserNote>?> getUserNotes(int userID) async {
    try {
      final response = await HttpHelper.postRequest(
        MainEndPoints.notes.name,
        NotesEndpoints.user_notes.name,
        {"user_id": userID},
      );
      if (response.statusCode < 300) {
        final List<dynamic> decoded = jsonDecode(response.body);
        final List<UserNote> userNotes =
            decoded.map((userNote) => UserNote.fromMap(userNote)).toList();

        return userNotes;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<UserNote?> addUserNote(UserNote userNote) async {
    try {
      final response = await HttpHelper.postRequest(
          MainEndPoints.notes.name, NotesEndpoints.user_note_add.name, {
        "user_id": userNote.userId,
        "note_type": userNote.noteType,
        "relevant_id": userNote.relevantId,
        "note_text": userNote.noteText
      });
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userNote = UserNote.fromMap(decoded);
        return userNote;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<UserNote?> updateUserNote(UserNote userNote) async {
    try {
      final response = await HttpHelper.patchRequest(
          MainEndPoints.notes.name,
          NotesEndpoints.user_note_update.name,
          {"note_id": userNote.id, "note_text": userNote.noteText});
      if (response.statusCode < 300) {
        final Map<String, dynamic> decoded = jsonDecode(response.body);
        final userNote = UserNote.fromMap(decoded);
        return userNote;
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
    return null;
  }

  @override
  Future<void> deleteUserNote(UserNote userNote) async {
    try {
      final response = await HttpHelper.deleteRequest(MainEndPoints.notes.name,
          NotesEndpoints.user_note_delete.name, {"note_id": userNote.id});
      if (response.statusCode < 300) {
        print('Okey');
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      ErrorExceptions.printError(e);
    }
  }
}
