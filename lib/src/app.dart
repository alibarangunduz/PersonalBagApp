import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
import 'package:mybagapp/src/providers/todo_provider.dart';
import 'package:mybagapp/src/screens/authentication.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: MaterialApp(
          home: Auth(),
          theme: ThemeData(
            primaryColor: Colors.black,
          )),
    );
  }
}