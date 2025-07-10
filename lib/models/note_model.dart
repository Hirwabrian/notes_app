class Note {
  final String id;
  final String text;

  Note({required this.id, required this.text});

  factory Note.fromMap(Map<String, dynamic> map, String id) {
    return Note(id: id, text: map['text'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {'text': text};
  }
}
