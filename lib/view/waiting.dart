import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/room_connection.dart';
import 'package:quizap/model/question.dart';
import 'package:quizap/view/categories.dart';
import 'package:quizap/view/questions.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  bool isCreator = false;
  late String roomCode;

  late Stream<QuerySnapshot> _listener;

  late StreamSubscription<QuerySnapshot> sub;

  @override
  void initState() {
    isCreator = Get.arguments["isCreator"];
    roomCode = Get.arguments["roomCode"];

    if (isCreator) {
      _listener = RoomConnection().getUserCount(roomCode: roomCode);
      sub = _listener.listen((event) {
        if (event.docs.length > 1) {
          Get.to(() => const CategoriesPage(),
              arguments: {"roomCode": roomCode, "isCreator": isCreator});
        }
      });
    } else {
      _listener = RoomConnection().getQuestionsPresent(roomCode: roomCode);
      sub = _listener.listen((event) {
        if (event.docs.isNotEmpty) {
          showDialog(
            barrierDismissible: false,
            builder: (ctx) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            },
            context: context,
          );
          RoomConnection().getRoomQuestions(roomCode: roomCode).then((res) {
            Navigator.of(context).pop();
            Question questions = Question.fromJson(res.docs.first.data());
            final args = {
              "questions": questions,
              "isCreator": isCreator,
              "roomCode": roomCode
            };
            Get.to(() => const QuestionsPage(), arguments: args);
          });
        }
      });
    }
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
                  isCreator
                      ? 'Waiting for other player'
                      : 'Waiting to choose the topic',
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
