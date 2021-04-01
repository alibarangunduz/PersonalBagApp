import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
class MyCalculator extends StatefulWidget {
  @override
  _MyCalculatorState createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  String inputs = "";
  String outputs = "";

  void handlebutton(String inputValue) {
    setState(() {
      inputs += inputValue;
    });
  }

  void handleCe(String inputValue) {
    setState(() {
      inputs = inputValue.substring(0, inputValue.length - 1);
    });
  }

  void handleEqual() {
    String questionInput = inputs;
    questionInput = questionInput.replaceAll('x', '*');
    Parser par = Parser();
    Expression expression = par.parse(questionInput);
    ContextModel modelContext = ContextModel();
    double evaluate = expression.evaluate(EvaluationType.REAL, modelContext);
    outputs = evaluate.toString();
  }

  Row buildButton({String input1, String input2, String input3, String input4}) {
    return Row(
      children: [
        SizedBox(
          height: 79,
          width: 15,
        ),
        Container(
          height: 60,
          width: 70,
          child: FlatButton(
            color: operators(input1) ? Colors.green[300] : Colors.grey[900],
            onPressed: () {
              if (input1 == 'AC') {
                handlebutton(inputs = "");
                handlebutton(outputs = "");
              } else
                handlebutton(input1);
            },
            child: Text(
              '$input1',
              style: TextStyle(
                  fontSize: 19,
                  color: operators(input1) ? Colors.white : Colors.blueGrey),
            ),
            shape: CircleBorder(side: BorderSide(width: 0.0)),
          ),
        ),
        SizedBox(
          height: 79,
          width: 15,
        ),
        Container(
          height: 60,
          width: 70,
          child: FlatButton(
            color: operators(input2) ? Colors.blue[400] : Colors.grey[900],
            onPressed: () {
              if (input2 == "CE") {
                handleCe(inputs);
                handlebutton(outputs = '');
              } else
                handlebutton(input2);
            },
            child: Text(
              '$input2',
              style: TextStyle(
                  fontSize: 19,
                  color: operators(input1) ? Colors.white : Colors.blueGrey),
            ),
            shape: CircleBorder(side: BorderSide(width: 0.0)),
          ),
        ),
        SizedBox(
          height: 79,
          width: 16,
        ),
        Container(
          height: 60,
          width: 70,
          child: FlatButton(
            color: operators(input3) ? Colors.pink : Colors.grey[900],
            onPressed: () {
              handlebutton(input3);
            },
            child: Text(
              '$input3',
              style: TextStyle(
                  fontSize: 21,
                  color: operators(input1) ? Colors.white : Colors.blueGrey),
            ),
            shape: CircleBorder(side: BorderSide(width: 0.0)),
          ),
        ),
        SizedBox(
          height: 79,
          width: 16,
        ),
        Container(
          height: 60,
          width: 70,
          child: FlatButton(
            color: Colors.pink,
            onPressed: () {
              if (input4 == "=") {
                setState(() {
                  handleEqual();
                });
              } else
                handlebutton(input4);
            },
            child: Text(
              '$input4',
              style: TextStyle(
                  color: operators(input4) ? Colors.white : Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0),
            ),
            shape: CircleBorder(side: BorderSide(width: 0.0)),
          ),
        ),
      ],
    );
  }

  bool operators(String operator) {
    if (operator == '%' ||
        operator == '/' ||
        operator == '-' ||
        operator == '+' ||
        operator == 'x' ||
        operator == '=' ||
        operator == '-/+' ||
        operator == 'AC' ||
        operator == 'CE') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      backgroundColor: Colors.grey[700],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    inputs,
                    style: TextStyle(fontSize: 21.0, color: Colors.blueGrey),
                  )),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    outputs,
                    style: TextStyle(fontSize: 40.0, color: Colors.white),
                  )),
            ),
            SizedBox(
              height: 39,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 1,
                width: 300,
                color: Colors.blueGrey,
              ),
            ),
            Column(
              children: <Widget>[
                buildButton(input1: 'AC', input2: 'CE', input3: '%', input4: '/'),
                buildButton(input1: '7', input2: '8', input3: '9', input4: 'x'),
                buildButton(input1: '4', input2: '5', input3: '6', input4: '-'),
                buildButton(input1: '1', input2: '2', input3: '3', input4: '+'),
                buildButton(input1: '00', input2: '0', input3: '.', input4: '='),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
