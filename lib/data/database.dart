import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List todoList = [];
  final _myBox = Hive.box('myBox');


  //initial data if the app opening first time
  // void createInitialData(){
  //   todoList = [
  //     ["exercise",false]
  //   ];
  // }


  //get data from database
  void loadData(){
    todoList=_myBox.get("TODOLIST");
  }


  //update the database
  void updateDataBase(){
    _myBox.put("TODOLIST", todoList);
  }
}