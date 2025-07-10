import 'package:flutter/material.dart';
import '../models/note_model.dart';
import '../services/notes_service.dart';

class NotesProvider with ChangeNotifier {
  final NotesService _service = NotesService();
  final String userId;

  List<Note> _notes = [];
  bool _isLoading = true;

  NotesProvider(this.userId) {
    loadNotes();
  }

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();

    try {
      _notes = await _service.fetchNotes(userId);
    } catch (e) {
      // error handling
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(String text, BuildContext context) async {
    final messeger = ScaffoldMessenger.of(context);
    await _service.addNote(userId, text);
    messeger.showSnackBar(const SnackBar(content: Text("Note added")));
    await loadNotes();
  }

  Future<void> updateNote(String id, String text, BuildContext context) async {
    final messeger = ScaffoldMessenger.of(context);
    await _service.updateNote(userId, id, text);
    messeger.showSnackBar(const SnackBar(content: Text("Note updated")));
    await loadNotes();
  }

  Future<void> deleteNote(String id, BuildContext context) async {
    final messeger = ScaffoldMessenger.of(context);
    await _service.deleteNote(userId, id);
    messeger.showSnackBar(const SnackBar(content: Text("Note deleted")));
    await loadNotes();
  }
}
