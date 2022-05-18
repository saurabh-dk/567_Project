import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/room_connection.dart';
import 'package:quizap/view/result.dart';

class FinalWaitingPage extends StatefulWidget {
  const FinalWaitingPage({Key? key}) : super(key: key);

  @override
  State<FinalWaitingPage> createState() => _FinalWaitingPageState();
}

class _FinalWaitingPageState extends State<FinalWaitingPage> {
  bool isCreator = false;
  late String roomCode;

  late Stream<DocumentSnapshot<Map<String, dynamic>>> _listener;

  late StreamSubscription<DocumentSnapshot> sub;

  int score = 0;

  @override
  void initState() {
    isCreator = Get.arguments["isCreator"];
    roomCode = Get.arguments["roomCode"];
    score = Get.arguments["score"];

    RoomConnection()
        .updateScores(code: roomCode, isCreator: isCreator, score: score);

    _listener = RoomConnection().monitorScores(roomCode: roomCode);

    sub = _listener.listen((event) {
      if (event.data()!.isNotEmpty) {
        Map<String, dynamic> vals = event.data()!;
        if (vals.containsKey("player2") && vals.containsKey("player1")) {
          // print(vals["player1"]);
          // print(vals["player2"]);
          int otherScore = isCreator ? vals["player2"] : vals["player1"];
          if (vals["player1"] == vals["player2"]) {
            final args = {
              "isTie": true,
              "score": score,
              "otherScore": otherScore,
              "isWinner": false,
              "isCreator": isCreator,
              "roomCode": roomCode
            };
            Get.to(() => const ResultPage(), arguments: args);
          } else {
            if (isCreator) {
              Map<String, dynamic> args;
              if (vals["player1"] > vals["player2"]) {
                args = {
                  "isWinner": true,
                  "isTie": false,
                  "score": score,
                  "otherScore": otherScore,
                  "isCreator": isCreator,
                  "roomCode": roomCode
                };
              } else {
                args = {
                  "isWinner": false,
                  "isTie": false,
                  "score": score,
                  "otherScore": otherScore,
                  "isCreator": isCreator,
                  "roomCode": roomCode
                };
              }
              Get.to(() => const ResultPage(), arguments: args);
            } else {
              Map<String, dynamic> args;
              if (vals["player2"] > vals["player1"]) {
                args = {
                  "isWinner": true,
                  "isTie": false,
                  "score": score,
                  "otherScore": otherScore,
                  "isCreator": isCreator,
                  "roomCode": roomCode
                };
              } else {
                args = {
                  "isWinner": false,
                  "isTie": false,
                  "score": score,
                  "otherScore": otherScore,
                  "isCreator": isCreator,
                  "roomCode": roomCode
                };
              }
              Get.to(() => const ResultPage(), arguments: args);
            }
          }
        }
      }
    });

    // if (isCreator) {
    //   _listener = RoomConnection().getUserCount(roomCode: roomCode);
    //   sub = _listener.listen((event) {
    //     if (event.docs.length > 1) {
    //       Get.to(() => const CategoriesPage(),
    //           arguments: {"roomCode": roomCode, "isCreator": isCreator});
    //     }
    //   });
    // } else {
    //   _listener = RoomConnection().getQuestionsPresent(roomCode: roomCode);
    //   sub = _listener.listen((event) {
    //     if (event.docs.isNotEmpty) {
    //       showDialog(
    //         barrierDismissible: false,
    //         builder: (ctx) {
    //           return const Center(
    //             child: CircularProgressIndicator(
    //               strokeWidth: 2,
    //             ),
    //           );
    //         },
    //         context: context,
    //       );
    //       RoomConnection().getRoomQuestions(roomCode: roomCode).then((res) {
    //         Navigator.of(context).pop();
    //         Question questions = Question.fromJson(res.docs.first.data());
    //         final args = {"questions": questions, "isCreator": isCreator};
    //         Get.to(() => const QuestionsPage(), arguments: args);
    //       });
    //     }
    //   });
    // }
    super.initState();
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Room code',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Text(
                roomCode,
                style: Theme.of(context).textTheme.headline5,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: AvatarGlow(
                  glowColor: Colors.blue,
                  endRadius: MediaQuery.of(context).size.width / 2,
                  duration: const Duration(milliseconds: 4000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: const Duration(milliseconds: 100),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/puzzle.png'),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Waiting for other player to finish",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
