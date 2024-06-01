import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {

  final String taskName;
  final bool taskCompleted;
  Function(bool?)?onChanged;
  Function(BuildContext)?deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding (
      padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
                onPressed: deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,)
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            children: [
              //check box
              Checkbox(value: taskCompleted,
                onChanged: onChanged,
                activeColor: Colors.black,),
              //Task name
              Text(
                taskName,
                style: TextStyle(fontSize: 20, decoration: taskCompleted? TextDecoration.lineThrough: TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
