import 'package:flutter/material.dart';
import '../widgets/widgets.dart';
import '../database_Helper.dart';
import '../models/models.dart';

class TaskPage extends StatelessWidget {
  static const RouteName = '/TaskPage';

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  bool _newTask = true;

  void onSubmit(BuildContext context) async {
    Task newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
    );
    DatabaseHelper db = DatabaseHelper();
    await db.insertTask(newTask);
    Navigator.of(context).pop();
  }

  void onDelete(BuildContext context) async
  {
    // This should be for the editable ones only
  }

  @override
  Widget build(BuildContext context) {
   Task task = ModalRoute.of(context)!.settings.arguments as Task;
   print(task);


    return Scaffold(
      //resizeToAvoidBottomInset: false,
      /* appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          OutlinedButton(onPressed: () => Navigator.pop(context), child: Text('Done')),
        ],
      ),*/
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
         /* Padding(
            padding: const EdgeInsets.all(4.0),
            child: FloatingActionButton(
              heroTag: 'FA1',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () =>
                  Navigator.of(context).pushNamed(TaskPage.RouteName),
              child: Image.asset('assets/images/delete_icon.png'),
              backgroundColor: const Color(0xFFFE3577),
            ),
          ),*/
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: FloatingActionButton(
              heroTag: 'FA2',
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              onPressed: () =>
                  onSubmit(context),
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
                      onTap: () => onSubmit(context),
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
