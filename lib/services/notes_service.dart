import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/note_model.dart';

class NotesService {
  final _firestore = FirebaseFirestore.instance;
  final _notesCollection = 'notes';

  Future<List<Note>> fetchNotes(String userId) async {
    final snapshot = await _firestore
        .collection(_notesCollection)
        .doc(userId)
        .collection('user_notes')
        .get();

    return snapshot.docs
        .map((doc) => Note.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> addNote(String userId, String text) async {
    await _firestore
        .collection(_notesCollection)
        .doc(userId)
        .collection('user_notes')
        .add({'text': text});
  }

  Future<void> updateNote(String userId, String id, String text) async {
    await _firestore
        .collection(_notesCollection)
        .doc(userId)
        .collection('user_notes')
        .doc(id)
        .update({'text': text});
  }

  Future<void> deleteNote(String userId, String id) async {
    await _firestore
        .collection(_notesCollection)
        .doc(userId)
        .collection('user_notes')
        .doc(id)
        .delete();
  }
}
