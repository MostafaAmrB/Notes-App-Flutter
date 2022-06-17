import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../database_Helper.dart';
import '../models/models.dart';
import '../providers/notes_provider.dart';
import 'package:provider/provider.dart';

class NotePage extends StatelessWidget {
  static const RouteName = '/NotePage';
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  //Indication for adding new Note , or viewing and updating old one
  bool _newNoteFlag = true;

  void addNote(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    Note newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch,
        title: _titleController.text,
        description: _descriptionController.text,
        createdDate: DateTime.now());

    notesProvider.insertNote(newNote);
    Navigator.of(context).pop();
  }

  void updateNote(BuildContext context, int updatedId) {
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    Note updatedNote = Note(
        id: updatedId,
        title: _titleController.text,
        description: _descriptionController.text,
        createdDate: DateTime.now());
    
    notesProvider.updateNote(updatedId, updatedNote);
    Navigator.of(context).pop();
  }

  void onDelete(BuildContext context) async {
    // This should be for the editable ones only
  }

  @override
  Widget build(BuildContext context) {
    Note? note = ModalRoute.of(context)!.settings.arguments as Note?;
    if (note != null) {
      _newNoteFlag = false;
      _titleController.text = note.title!;
      _descriptionController.text = note.description!;
    }
    print(note);

    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FloatingActionButton(
              heroTag: 'FA2',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () => _newNoteFlag
                  ? addNote(context)
                  : updateNote(context, note!.id!),
              child: const Icon(Icons.save),
              backgroundColor: const Color(0xFF7349FE),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Image.asset('assets/images/back_arrow_icon.png'),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Title here',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF211551)),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    TextField(
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        hintText: 'Enter Description here',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      ),
                      style: const TextStyle(
                        color: Color(0xFF86829D),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLength: null,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
