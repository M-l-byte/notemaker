import 'package:flutter/material.dart';
import 'package:znotes/db/database_provider.dart';
import 'package:znotes/model/note_model.dart';

class EditNoteScreen extends StatefulWidget {
  final NoteModel note;

  EditNoteScreen({required this.note});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _bodyController = TextEditingController(text: widget.note.body);
  }

  @override
  Widget build(BuildContext context) {
    print("EditNoteScreen - build");
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _bodyController,
              decoration: InputDecoration(labelText: 'Body'),
              maxLines: null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateNote,
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  void _updateNote() async {
    print("Updating note...");
    NoteModel updatedNote = NoteModel(
      id: widget.note.id,
      title: _titleController.text,
      body: _bodyController.text,
      creation_date: DateTime.now(),
    );
    await DatabaseProvider.db.updateNote(updatedNote);
    print("Note updated successfully!");
    Navigator.pop(context);
  }
}
