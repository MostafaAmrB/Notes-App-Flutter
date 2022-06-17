// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables , prefer_final_fields

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';
import './screens.dart';
import '../models/models.dart';
import '../providers/notes_provider.dart';
import '../database_Helper.dart';

class HomePage extends StatelessWidget {
  static String RouteName = '/HomePage';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () => Navigator.of(context).pushNamed(NotePage.RouteName),
        child: Image.asset('assets/images/add_icon.png'),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: Container(
        padding: const EdgeInsets.all(30),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                'assets/images/logo.png',
              ),
            ),
            Expanded(
              child: Consumer<NotesProvider>(builder: (_, provider, __) {
                if (provider.notes.length == 0) {
                  return _buildEmptyTasksContainer();
                }

                return ListView.builder(
                  itemCount: provider.notes.length,
                  itemBuilder: (_, index) {
                    print(provider.notes[index].toString());
                    return NoteCard(
                      note: provider.notes[index],
                    );
                  },
                );
              }),
            ),
            /* Expanded(
              child: Consumer<NotesProvider>(
                builder: (_, provider, __) {
                  return FutureBuilder(
                    future: provider.fetchData(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final notes = snapshot.data as List<Note>;
                        print(notes.length);
                        return ListView.builder(
                          itemCount: provider.notes.length,
                          itemBuilder: (_, index) {
                            print(provider.notes[index].toString());
                            return NoteCard(
                              note: provider.notes[index],
                            );
                          },
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return const Center(
                        child: Text('No Tasks have been added yet'),
                      );
                    },
                  );
                },
              ),
            ),*/
            /*Expanded(
              child: FutureBuilder(
                future: DatabaseHelper().fetchTasks(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final tasks = snapshot.data as List<Task>;
                    print(tasks.length);
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (_, index) {
                        print(tasks[index].toString());
                        return TaskCard(
                          task: tasks[index],
                        );
                      },
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return const Center(
                    child: Text('No Tasks have been added yet'),
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyTasksContainer() {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/note_logo_1.png',
              height: 100,
              width: 100,
            ),
            SizedBox(height: 10),
            Text(
              'Empty Notes !',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
