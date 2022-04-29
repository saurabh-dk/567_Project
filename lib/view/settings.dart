import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';
import 'package:quizap/view/login.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  (AuthenticationHelper().getUser() != null)
                      ? (AuthenticationHelper().getUser()!.email!)
                      : "Testing",
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: TextButton.icon(
                    label: Text("Go Back".toUpperCase()),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                          letterSpacing: 2, fontWeight: FontWeight.bold),
                    ),
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Center(
                  child: RoundedButton(
                    outlined: false,
                    isLoading: _isLoading,
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      AuthenticationHelper()
                          .signOut()
                          .then((value) => Get.offAll(() => const LoginPage()));
                    },
                    text: "LOG OUT",
                    backgroundColor: Colors.red,
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
