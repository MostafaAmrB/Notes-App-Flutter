import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notes_provider.dart';
import '../screens/screens.dart';
import '../models/models.dart';
import '../screens/screens.dart';
import '../database_Helper.dart';

class NoteCard extends StatelessWidget {
  Note note;

  NoteCard({required this.note});
  @override
  Widget build(BuildContext context) {
    final _notesProvider = Provider.of<NotesProvider>(context , listen: false);

    // TODO: implement build
    return GestureDetector(
      onTap: () {
        //Should Navigate to update the Selected note
        Navigator.of(context).pushNamed(NotePage.RouteName , arguments: note);
      },
      onLongPress: () {
        SnackBar snackBar = SnackBar(
          content: const Text('Do you want to delete that note ? '),
          action: SnackBarAction(
            label: 'Confirm',
            onPressed: () async {
              //await DatabaseHelper().deletenote(note.id!);
              _notesProvider.deleteNote(note.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('note with ID ${note.id!} is successfully deleted !'),
                ),
              );
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                note.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                note.description!,
                style: const TextStyle(
                  color: Color(0xFF86829D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
