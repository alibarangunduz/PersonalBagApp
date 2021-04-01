import 'package:flutter/material.dart';
import 'package:mybagapp/main.dart';
import 'package:mybagapp/src/services/authentication_service.dart';
import 'authentication.dart';
import 'calculator.dart';
import 'todoScreen.dart';
import 'homeTodoScreen.dart';
import 'showCoins.dart';
import 'light.dart';


class Welcome extends StatelessWidget {
  TodoScreen emptyTodo;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('MyBag'),
          actions: [
            IconButton(
              icon: Icon(Icons.close_outlined),
              tooltip: 'SignOut',
              onPressed: () {
                signOut();
                Restart.restartApp(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Auth()));
              },
            ),
          ],
        ),
        body: Center(
          child: Column(

            children: [
              SizedBox(
                height: 130,
                width: 15,
              ),
              Text("Select your tool",
                style:
                TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontStyle: FontStyle.italic
              ),),
              SizedBox(
                height: 30,
                width: 15,
              ),
              Container(
              margin: const EdgeInsets.only(left: 85),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(children: [
                    RaisedButton(
                      color: Colors.blue,
                      child: Text('Todo', style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeTodoScreen(),
                          ),
                        );
                      }
                    ),
                    SizedBox(
                      height: 10,
                      width: 10,
                    ),
                    RaisedButton(
                      color: Colors.green,
                      child: Text('Calculator', style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyCalculator(),
                            ),
                          );
                        }
                    ),
                  ]),
                  SizedBox(
                    height: 15,
                    width: 10,
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        color: Colors.orangeAccent,
                        child: Text('Currency', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShowCoins(),
                              ),
                            );
                          }
                      ),
                      SizedBox(
                        height: 10,
                        width: 8,
                      ),
                      RaisedButton(

                        color: Colors.black,
                        child: Text('FlashLight', style: TextStyle(color: Colors.white)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FlashLight(),
                              ),
                            );
                          }
                      ),
                    ],
                  ),

                ],
              ),
            ),
            ],
          ),
        ));
  }
}
