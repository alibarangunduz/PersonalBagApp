import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mybagapp/src/app.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( Restart(
    child: App(),
  ),);
}
//https://stackoverflow.com/questions/50115311/flutter-how-to-force-an-application-restart-in-production-mode kaynak programı resetlemesi için
class Restart extends StatefulWidget {
  Restart({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartState>().restartApp();
  }

  @override
  _RestartState createState() => _RestartState();
}

class _RestartState extends State<Restart> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}