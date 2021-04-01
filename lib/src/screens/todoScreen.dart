import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mybagapp/src/models/todo.dart';
import 'package:mybagapp/src/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatefulWidget {
  final Todo todo;

  TodoScreen({this.todo});

  @override
  TodoScreenState createState() => TodoScreenState();
}

class TodoScreenState extends State<TodoScreen> {

  final todoController = TextEditingController();

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    final todoProvider = Provider.of<TodoProvider>(context,listen: false);
    if (widget.todo != null){
      //Edit
      todoController.text = widget.todo.todo;

      todoProvider.loadAll(widget.todo);
    } else {
      //Add
      todoProvider.loadAll(null);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text(formatDate(todoProvider.date, [MM, ' ', d, ', ', yyyy]))
          ,actions: [
            IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: (){
                _pickDate(context,todoProvider).then((value) {
                  if (value != null){
                    todoProvider.changeDate = value;
                  }
                });
              },
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Daily Todo', border: InputBorder.none,
              ),
              maxLines: 12,
              minLines: 10,
              onChanged: (String value) => todoProvider.changeTodo = value,
              controller: todoController,
            ),
            RaisedButton(
              color: Colors.blue,
              child: Text('Save',style: TextStyle(color: Colors.white)),
              onPressed: () {
                todoProvider.saveTodo();
                Navigator.of(context).pop();
              },
            ),
            (widget.todo != null) ? RaisedButton(
              color: Colors.red,
              child: Text('Delete',style: TextStyle(color: Colors.white)),
              onPressed: () {
                todoProvider.removeTodo(widget.todo.todoId);
                Navigator.of(context).pop();
              },
            ): Container(),
          ],
        ),
      ),
    );
  }

  Future<DateTime> _pickDate(BuildContext context, TodoProvider todoProvider) async {
    final DateTime picked = await showDatePicker(
        context: context, initialDate: todoProvider.date, firstDate: DateTime(2015),
        lastDate: DateTime(2040));

    if (picked != null) return picked;

     return DateTime.now();
  }
}