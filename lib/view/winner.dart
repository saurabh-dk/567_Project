import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quizap/view/questions.dart';
import 'package:quizap/view/waiting.dart';

import 'custom_widgets/rounded_button.dart';
import 'login.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Congratulations \n You Won!',
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          Image(
            image: const AssetImage('winner.png'),
            height: MediaQuery.of(context).size.height * 0.25,
          ),
          const SizedBox(height: 50),
          const Text(
            'You got \n 9/10 \n right',
            style: TextStyle(fontSize: 20, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          RoundedButton(
            outlined: false,
            onPressed: () {
              Get.to(() => const TopicPage());
            },
            maxWidth: MediaQuery.of(context).size.width * 0.6,
            text: 'Play Again'.toUpperCase(),
          ),
          const SizedBox(height: 20),
          TextButton(
              child: const Text('EXIT ROOM'),
              style: TextButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Get.to(() => const LoginPage());
              })
        ], //<Widget>[]
      ), //Column
    );
  }
}
