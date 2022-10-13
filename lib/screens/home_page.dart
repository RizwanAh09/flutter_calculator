import 'package:flutter/material.dart';
import 'package:flutter_calculator/widgets/buttons.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = "";
  var userAnswer = "";
  final List<String> buttons = [
    "C",
    "DEL",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "ANS",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      userQuestion,
                      style: const TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          )),
          Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                    itemBuilder: ((context, index) {
                      /// clear Button
                      if (index == 0) {
                        return MyButtons(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = "";
                              });
                            },
                            color: Colors.green,
                            textColor: Colors.white,
                            buttonText: buttons[index]);

                        /// Delete Button
                      } else if (index == 1) {
                        return MyButtons(
                            buttonTapped: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            buttonText: buttons[index]);
                      }

                      /// Equal Button
                      else if (index == buttons.length - 1) {
                        return MyButtons(
                            buttonTapped: () {
                              setState(() {
                                equalPressed();
                              });
                            },
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                            buttonText: buttons[index]);
                      } else {
                        return MyButtons(
                            buttonTapped: () {
                              setState(() {
                                userQuestion += buttons[index];
                              });
                            },
                            color: isOperator(buttons[index])
                                ? Colors.deepPurple
                                : Colors.deepPurple[50],
                            textColor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.deepPurple,
                            buttonText: buttons[index]);
                      }
                    })),
              )),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == "%" || x == "/" || x == "-" || x == "=" || x == "+" || x == "x") {
      return true;
    }
    return false;
  }

  equalPressed() {
    String question = userQuestion;
    question = question.replaceAll("x", "*");
    Parser parser = Parser();
    Expression expression = parser.parse(question);

    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    userAnswer = eval.toString();
  }
}
