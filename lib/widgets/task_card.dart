import 'package:flutter/material.dart';
import 'package:todolist_final/screens/task_page.dart';
import '../models/models.dart';
import '../screens/screens.dart';
import '../database_Helper.dart';

class TaskCard extends StatelessWidget {
  Task task;

  TaskCard({required this.task});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        //Should Navigate to update the Selected Task
        Navigator.of(context).pushNamed(TaskPage.RouteName , arguments: task);
      },
      onLongPress: () {
        SnackBar snackBar = SnackBar(
          content: const Text('Do you want to delete that task ? '),
          action: SnackBarAction(
            label: 'Confirm',
            onPressed: () async {
              await DatabaseHelper().deleteTask(task.id!);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Task with ID ${task.id!} is successfully deleted !'),
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
                task.title!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                task.description!,
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
