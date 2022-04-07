import 'package:flutter/material.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({Key? key}) : super(key: key);

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 24, 8, 56),
                    child: Material(
                      child: TextField(
                        textAlign: TextAlign.center,
                        textCapitalization: TextCapitalization.characters,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter the invite code',
                        ),
                      ),
                    ),
                  ),
                  RoundedButton(
                    outlined: false,
                    onPressed: () {},
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
                    onPressed: () {},
                    maxWidth: MediaQuery.of(context).size.width * 0.6,
                    text: 'Create a room'.toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(
              child: TextButton.icon(
                label: Text("Settings".toUpperCase()),
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                      letterSpacing: 2, fontWeight: FontWeight.bold),
                ),
                icon: const Icon(Icons.settings),
                onPressed: () {},
              ),
            ),
          )
        ],
      ),
    );
  }
}
