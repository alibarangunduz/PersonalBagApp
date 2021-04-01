import 'package:flutter/material.dart';

class Todo {

  final String todoId;
  final String date;
  final String todo;

  Todo({this.date, this.todo, @required this.todoId});

  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
        date: json['date'],
        todo: json['todo'],
        todoId: json['todoId']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'date': date,
      'todo':todo,
      'todoId':todoId
    };
  }
}