import 'package:flutter/material.dart';

class ToDoWidget extends StatelessWidget {
  final String taskTitle;
  final bool isDone;

  ToDoWidget({required this.taskTitle , required this.isDone});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 5),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: isDone ? const Color(0xFF7349FE) :  Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isDone ? Border.all(color: const Color(0xFF7349FE) ) : Border.all(),
            ),
            child: Image.asset('assets/images/check_icon.png'),
          ),
          Text(
            taskTitle,
            style: TextStyle(
              color: isDone ? const Color(0xFF211551) : const Color(0xFF86829D),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
