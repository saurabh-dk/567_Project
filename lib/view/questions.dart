import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';
import 'package:quizap/view/login.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage>
    with TickerProviderStateMixin {
  late AnimationController controller;

  Color first = Colors.green;
  Color second = Colors.red;

  bool isSelected = false;

  final PageController pageController = PageController();

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    controller.reverse(from: 10.0);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String _getVal(double val) {
    return (val * 10).round().toString();
  }

  void selection() {
    setState(() {
      isSelected = true;
      if (!isSelected) {
        controller.stop();
      } else {
        controller.stop(canceled: true);
        controller.forward(from: 10);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          LinearProgressIndicator(value: controller.value, minHeight: 12),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              _getVal(controller.value),
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Who created Flutter Framework?",
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RoundedButton(
              outlined: true,
              onPressed: selection,
              text: "Google",
              textColor: Colors.black,
              backgroundColor: isSelected ? first : Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RoundedButton(
              outlined: true,
              onPressed: selection,
              text: "Microsoft",
              textColor: Colors.black,
              backgroundColor: isSelected ? second : Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RoundedButton(
              outlined: true,
              onPressed: selection,
              text: "Facebook",
              textColor: Colors.black,
              backgroundColor: isSelected ? second : Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: RoundedButton(
              outlined: true,
              onPressed: selection,
              text: "Yahoo",
              textColor: Colors.black,
              backgroundColor: isSelected ? second : Colors.black,
            ),
          ),
        ],
      )),
    );
  }
}
