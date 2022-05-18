import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/view/change_name.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';
import 'package:quizap/view/login.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLoading = false;

  String? displayName;

  @override
  void initState() {
    displayName = AuthenticationHelper().getUser()!.displayName;
    super.initState();
  }

  void _getName() {
    setState(() {
      displayName = AuthenticationHelper().getUser()!.displayName;
    });
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image(
                    image: const AssetImage('assets/puzzle.png'),
                    height: MediaQuery.of(context).size.height * 0.25,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    AuthenticationHelper().getUser()!.email!,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          (displayName == null) ? "No name set" : displayName!,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return const ChangeNamePage();
                                }).then((value) => _getName());
                          },
                          icon: const Icon(Icons.edit))
                    ],
                  ),
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
