import 'package:flutter/material.dart';
import 'package:mybagapp/src/models/todo.dart';
import 'package:mybagapp/src/services/todo_service.dart';
import 'package:uuid/uuid.dart';

class TodoProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  DateTime _date;
  String _todo;
  String _todoId;
  var uuid = Uuid();

  //Getters
  DateTime get date => _date;
  String get todo => _todo;
  Stream<List<Todo>> get entries => firestoreService.getEntries();

  //Setters
  set changeDate(DateTime date){
    _date = date;
    notifyListeners();
  }

  set changeTodo(String todo){
    _todo = todo;
    notifyListeners();
  }

  //Functions
  loadAll(Todo todo){
    if (todo != null){
      _date = DateTime.parse(todo.date);
      _todo =todo.todo;
      _todoId = todo.todoId;
    } else {
      _date = DateTime.now();
      _todo = null;
      _todoId = null;
    }
  }

  saveTodo(){
    if (_todoId == null){
      //Add
      var newTodo = Todo(date: _date.toIso8601String(), todo: _todo, todoId: uuid.v1());
      print(newTodo.todo);
      firestoreService.setTodo(newTodo);
    } else {
      //Edit
      var updatedTodo = Todo(date: _date.toIso8601String(), todo: _todo, todoId: _todoId);
      firestoreService.setTodo(updatedTodo);
    }
  }

  removeTodo(String todoId){
    firestoreService.removeTodo(todoId);
  }

}