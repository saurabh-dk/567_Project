import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/view/categories.dart';
import 'package:quizap/view/winner.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';
import 'package:quizap/view/settings.dart';
import 'package:quizap/view/waiting.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create or Join the room',
                style: Theme.of(context).textTheme.headline5,
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 24, 8, 56),
                        child: Material(
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.characters,
                            style: const TextStyle(fontSize: 18),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100))),
                              hintText: 'Enter the invite code',
                            ),
                            onSaved: (val) {
                              FocusManager.instance.primaryFocus?.unfocus();
                            },
                          ),
                        ),
                      ),
                      RoundedButton(
                        outlined: false,
                        onPressed: () {
                          Get.to(() => const WaitingPage());
                        },
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                        text: 'Join now!'.toUpperCase(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 56),
                        child: Text(
                          "OR",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      RoundedButton(
                        outlined: false,
                        onPressed: () {
                          // TO-DO CHANGE THIS
                          Get.to(ResultPage());
                        },
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                        text: 'Create a room'.toUpperCase(),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Center(
                  child: TextButton.icon(
                    label: Text("Settings".toUpperCase()),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          letterSpacing: 2, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Get.to(() => const SettingsPage());
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
