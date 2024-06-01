import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';
class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
  }


  class _HomePageState extends State<HomePage>{

    final _myBox = Hive.box('myBox');
    ToDoDataBase db = ToDoDataBase();

    @override
  void initState() {
    //if this is the first time
      if(_myBox.get("TODOLIST")==null) {

      }else{
        db.loadData();
      }
    super.initState();
  }

    final _controller = TextEditingController();



    //checkbox changed
    void checkBoxChanged(bool? value,int index){
      setState(() {
        db.todoList[index][1] = !db.todoList[index][1];
      });
      db.updateDataBase();
    }
    //save new task
    void saveNewTask(){
      setState(() {
        db.todoList.add([_controller.text, false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDataBase();
    }

    void createNewTask(){
      showDialog(
          context: context,
          builder: (context){
            return DialogBox(
              controller: _controller,
              onSave: saveNewTask,
              onCancel: Navigator.of(context).pop,
            );
          },
      );
    }

    void deleteTask(int index){
      setState(() {
        db.todoList.removeAt(index);
      });
      db.updateDataBase();
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.yellow[200],
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text("To Do", style: TextStyle(fontWeight: FontWeight.bold),),
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewTask,
          child: Icon(Icons.add),),
        body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index){
            return ToDoTile(
                taskName: db.todoList[index][0],
                taskCompleted: db.todoList[index][1],
                onChanged: (value) => checkBoxChanged(value, index),
                deleteFunction: (context) => deleteTask(index),
            );
          },
        ),

      );
    }
  }
