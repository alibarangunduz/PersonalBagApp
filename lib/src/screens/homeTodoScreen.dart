import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:mybagapp/src/models/todo.dart';
import 'package:mybagapp/src/providers/todo_provider.dart';
import 'package:mybagapp/src/screens/todoScreen.dart';
import 'package:provider/provider.dart';

class HomeTodoScreen extends StatefulWidget {
  @override
  _HomeTodoScreenState createState() => _HomeTodoScreenState();
}

class _HomeTodoScreenState extends State<HomeTodoScreen> {
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Todos'),
      ),
      body: StreamBuilder<List<Todo>>(
          stream: todoProvider.entries,
          builder: (context, snapshot) {
            return ListView.builder(

                itemCount: snapshot?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(

                    focusColor: Colors.blue,
                    trailing:
                    Icon(Icons.edit, color: Colors.blue),
                    title: Text(
                      formatDate(DateTime.parse(snapshot.data[index].date),
                          [MM, ' ', d, ', ', yyyy]),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              TodoScreen(todo: snapshot.data[index])));
                    },
                  );
                });
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoScreen()));
        },
      ),
    );
  }
}