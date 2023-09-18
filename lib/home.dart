// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String equation = "";
  String result = "";

  String expression = "";
  Color mint = Color.fromARGB(255, 77, 238, 128);
  Color blue = const Color.fromARGB(255, 73, 86, 255);
  Color green = Color.fromARGB(255, 31, 241, 98);

  buttonCal(String ButtonText) {
    setState(() {
      if (ButtonText == 'C') {
        equation = '0';
        result = '0';
      } else if (ButtonText == 'Del') {
        equation = equation.substring(0, equation.length - 1);
        if (equation == '0') {
          equation = '0';
        } else if (ButtonText == '=') {
          expression = equation;
          expression = expression.replaceAll('x', '*');

          expression = expression.replaceAll('÷', '/');

          try {
            Parser p = Parser();
            Expression exp = p.parse(expression);
            ContextModel cm = ContextModel();
            result = exp.evaluate(EvaluationType.REAL, cm);
          } catch (e) {
            result = "Error";
          }
        } else {
          if (equation == '0') {
            equation = '0';
          }
          equation = equation + ButtonText;
        }
      }
    });
  }

  Widget myCustomButton(
      String buttontext, double buttonheight, Color buttoncolour) {
    return Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        child: Container(
          height: buttonheight * 70,
          decoration: BoxDecoration(
              color: buttoncolour, borderRadius: BorderRadius.circular(100)),
          child: MaterialButton(
            onPressed: () {
              buttonCal(buttontext);
            },
            child: Text(
              buttontext,
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("The Caclulator"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        // ignore: prefer_const_constructors, prefer_const_constructors
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Text(
              equation,
              style: const TextStyle(fontSize: 70, color: Colors.black),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Text(
              result,
              style: const TextStyle(fontSize: 60, color: Colors.black),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 1,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      myCustomButton("C", 1, mint),
                      myCustomButton("Del", 1, mint),
                      myCustomButton("÷", 1, mint),
                    ]),
                    TableRow(children: [
                      myCustomButton("7", 1, mint),
                      myCustomButton("8", 1, mint),
                      myCustomButton("9", 1, mint),
                    ]),
                    TableRow(children: [
                      myCustomButton("4", 1, mint),
                      myCustomButton("5", 1, mint),
                      myCustomButton("6", 1, mint),
                    ]),
                    TableRow(children: [
                      myCustomButton("1", 1, mint),
                      myCustomButton("2", 1, mint),
                      myCustomButton("3", 1, mint),
                    ]),
                    TableRow(children: [
                      myCustomButton(".", 1, mint),
                      myCustomButton("0", 1, mint),
                      myCustomButton("00", 1, mint),
                    ])
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      myCustomButton("x", 1, mint),
                    ]),
                    TableRow(children: [
                      myCustomButton("-", 1, mint),
                    ]),
                    TableRow(children: [
                      myCustomButton("+", 1, mint),
                    ]),
                    TableRow(children: [
                      myCustomButton("=", 2, green),
                    ]),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
