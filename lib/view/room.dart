import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/room_connection.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';
import 'package:quizap/view/settings.dart';
import 'package:quizap/view/waiting.dart';
import 'dart:math';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  String? code;

  bool _isLoading = false;

  String generateCode(int len) {
    var r = Random.secure();
    const _chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: TextField(
                            textAlign: TextAlign.center,
                            textCapitalization: TextCapitalization.characters,
                            style: const TextStyle(fontSize: 18),
                            onChanged: (value) {
                              setState(() {
                                code = value;
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Enter the invite code',
                            ),
                          ),
                        ),
                      ),
                      RoundedButton(
                        outlined: false,
                        isLoading: _isLoading,
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          RoomConnection().addUserToRoom(roomCode: code!).then(
                            (value) {
                              setState(() {
                                _isLoading = false;
                              });
                              if (value) {
                                Get.to(() => const WaitingPage());
                              }
                            },
                          );
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
                          final code = generateCode(9);
                          RoomConnection().createRoom(code: code).then((value){
                            Get.to(() => const WaitingPage());
                          });
                        },
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                        text: 'Create a room'.toUpperCase(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
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
