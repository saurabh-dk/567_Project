import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/view/categories.dart';

import 'custom_widgets/rounded_button.dart';

class WaitingPage extends StatefulWidget {
  const WaitingPage({Key? key}) : super(key: key);

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  // void _incrementCounter() {}

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
                'ABC-123-XYZ',
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
                  'Waiting for other player',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: TextButton.icon(
                    label: Text("Next".toUpperCase()),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          letterSpacing: 2, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      Get.to(() => const CategoriesPage());
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
