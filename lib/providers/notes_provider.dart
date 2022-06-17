// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables , prefer_final_fields

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import '../models/models.dart';

class NotesProvider extends ChangeNotifier {
  
  List<Note> _notes = [];
  late Database db;
  List<Note> get notes => [..._notes];

  NotesProvider() {
    // On Creating Provider i need to open connection with database and fetch data from it
    //and place them in _notes list
    openConnection();
  }

  void openConnection() async {
    String dbName = 'tempNotes.db';
    String createTableQuery =
        'CREATE TABLE Notes(id INTEGER PRIMARY KEY, title TEXT, description TEXT , createdDate TEXT)';
    db = await DBHelper.openConnection(
        databaseName: dbName, createTableQuery: createTableQuery);
    fetchData();
  }

  Future<List<Note>> fetchData() async {
    print('fetching Notes');
    
    // Query the table for all The Notes.
    final List<Map<String, dynamic>> maps = await db.query('Notes');

    // Convert the List<Map<String, dynamic> into a List<Task>.
    _notes = List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        createdDate: DateTime.tryParse(maps[i]['createdDate']),
      );
    });
    notifyListeners();
    return _notes;
  }

  void insertNote(Note newNote) async {
    try {
      await db.insert(
        'Notes',
        newNote.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // To add it at the end of the list
      // _notes.add(newNote);

      //To add it the start of the list
      _notes.insert(0, newNote);
      print('Successfully added on DB : $newNote');
      print('Successfully added on List');
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void deleteNote(int id) async {
    
    try {
      int result = await db.delete(
      'Notes',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
    _notes.removeWhere((element) => element.id == id);
    print('Result of the query $result');
    print('Successfully deleted from DB');
    notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  void updateNote(int id, Note updatedNote) async {

    int result = await db.update(
      'Notes',
      updatedNote.toMap(),
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [updatedNote.id],
    );
    print('Result of Update : $result');
    int index = _notes.indexWhere((element) => element.id == id);
    _notes.removeAt(index);
    _notes.insert(index, updatedNote);
    print('Updated Successfully');
    notifyListeners();
  }
}

class DBHelper {
  static Future<Database> openConnection(
      {required String databaseName, required String createTableQuery}) async {
    final database = await openDatabase(
      join(await getDatabasesPath(), databaseName),
      // When the database is first created, create a table to store tasks.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        print('Called Create  Now');
        return db.execute(
          createTableQuery,
        );
      },
      version: 1,
    );
    print('Connection Opened');
    return database;
  }
}


/*List<Note> _notes = [
    Note(
        id: 1,
        title: 'First Note',
        description: 'To be considered later',
        createdDate: DateTime.now()),
    Note(
        id: 2,
        title: 'Another',
        description: 'To be considered later',
        createdDate: DateTime.now()),
    Note(
        id: 3,
        title: 'New Note',
        description: 'To be considered later',
        createdDate: DateTime.now()),
    Note(
        id: 4,
        title: 'Note',
        description: 'To be considered later',
        createdDate: DateTime.now()),
    Note(
        id: 5,
        title: 'Final End',
        description: 'To be considered later',
        createdDate: DateTime.now()),
  ];*/