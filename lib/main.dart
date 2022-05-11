import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/view/login.dart';
import 'package:quizap/view/room.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
        home: AuthenticationHelper().getUser() != null
            ? const RoomPage()
            : const LoginPage());
  }
}
