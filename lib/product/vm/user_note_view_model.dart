import 'package:deu_cis/product/models/user_notes.dart';
import 'package:deu_cis/product/services/model_service/user_note_service.dart';
import 'package:flutter/material.dart';

class UserNoteViewModel extends ChangeNotifier {
  List<UserNote>? _userNotes;
  List<UserNote>? get userNotes => _userNotes;
  IUserNoteService _userNoteService = UserNoteService();

  Future<void> fetchUserNotes(int userID) async {
    _userNotes = null;
    _userNotes = await _getUserNotes(userID);
    notifyListeners();
  }

  Future<List<UserNote>?> _getUserNotes(int userID) async {
    return await _userNoteService.getUserNotes(userID);
  }

  Future<void> updateUserNote(UserNote userNote) async {
    await _userNoteService.updateUserNote(userNote);
    if (_userNotes != null) {
      int index =
          _userNotes!.indexWhere((element) => element.id == userNote.id);
      if (index != -1) {
        _userNotes![index] = userNote;
        notifyListeners();
      }
    }
  }

  Future<void> deleteUserNote(UserNote userNote) async {
    await _userNoteService.deleteUserNote(userNote);
    int index = _userNotes!.indexWhere((element) => element.id == userNote.id);
    if (index != -1) {
      _userNotes!.removeAt(index);
      notifyListeners();
    }
  }
}
