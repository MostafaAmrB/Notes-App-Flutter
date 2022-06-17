// ignore_for_file: file_names
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import './models/models.dart';
import 'package:flutter/widgets.dart';

class DatabaseHelper {
  Future<Database> openConnection() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'todoapp.db'),
      // When the database is first created, create a table to store tasks.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, description TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  // A method that retrieves all the tasks from the tasks table.
  Future<List<Task>> fetchTasks() async {
    // Get a reference to the database.
    final db = await openConnection();

    // Query the table for all The Tasks.
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Task>.
    return List.generate(maps.length, (i) {
      return Task(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
      );
    });
  }

  // Define a function that inserts tasks into the database
  Future<void> insertTask(Task task) async {
    // Get a reference to the database.
    final db = await openConnection();

    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print('Task is Successfully added');
  }

  Future<void> updateTask(Task task) async {
    // Get a reference to the database.
    final db = await openConnection();

    // Update the given Dog.
    await db.update(
      'tasks',
      task.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id],
    );
  }

  Future<void> deleteTask(int id) async {
    // Get a reference to the database.
    final db = await openConnection();

    // Remove the Dog from the database.
    await db.delete(
      'tasks',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
