import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/room_connection.dart';
import 'package:quizap/view/categories.dart';
import 'package:quizap/view/room.dart';

import 'custom_widgets/rounded_button.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late int score, otherScore;

  late bool isTie, isWinner, isCreator;

  late AssetImage image;

  late String resultText, scoreText, player2Text, roomCode;

  @override
  void initState() {
    score = Get.arguments["score"];
    isTie = Get.arguments["isTie"];
    isWinner = Get.arguments["isWinner"];
    otherScore = Get.arguments["otherScore"];
    isCreator = Get.arguments['isCreator'];
    roomCode = Get.arguments['roomCode'];

    if (isTie) {
      image = const AssetImage('assets/tie.png');
      resultText = "It's a tie!\nBetter luck next time";
    } else if (isWinner) {
      image = const AssetImage('assets/winner.png');
      resultText = "Congratulations!\nYou won!";
    } else {
      image = const AssetImage('assets/loser.png');
      resultText = "You lost!\nBetter luck next time";
    }

    scoreText = "You got\n" + score.toString() + "/10" + "\nright";
    player2Text =
        "Player 2 answered " + otherScore.toString() + "/10" + " correctly";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              resultText,
              style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Image(
              image: image,
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            const SizedBox(height: 50),
            Text(
              scoreText,
              style: const TextStyle(fontSize: 20, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            Text(
              player2Text,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 50),
            // RoundedButton(
            //   outlined: false,
            //   onPressed: () {
            //     Get.offAll(() => const CategoriesPage());
            //   },
            //   maxWidth: MediaQuery.of(context).size.width * 0.6,
            //   text: 'Play Again'.toUpperCase(),
            // ),
            const SizedBox(height: 20),
            TextButton(
                child: const Text('EXIT ROOM'),
                style: TextButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  RoomConnection()
                      .deleteCurrentRoom(roomCode: roomCode)
                      .then((_) {
                    Get.offAll(() => const RoomPage());
                  });
                })
          ], //<Widget>[]
        ), //Column
      ),
    );
  }
}
