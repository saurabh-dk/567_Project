import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizap/view/login.dart';
import 'package:quizap/view/room.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'quizap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RoomPage(),
    );
  }
}
