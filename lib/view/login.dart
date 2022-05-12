import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/view/custom_widgets/email_login.dart';
import 'package:quizap/view/room.dart';
import 'package:quizap/view/signup.dart';

import 'custom_widgets/rounded_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Expanded(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Image(
                  image: const AssetImage('assets/puzzle.png'),
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('quizap',
                    style: Theme.of(context).textTheme.headline5),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: RoundedButton(
                        outlined: false,
                        onPressed: () => {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            elevation: 4,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return const LoginForm();
                            },
                          ),
                        },
                        text: "Login with Email",
                        icon: Icons.alternate_email_outlined,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: RoundedButton(
                        outlined: false,
                        onPressed: () {
                          AuthenticationHelper()
                              .signInWithGoogle()
                              .then((result) {
                            if (result == null) {
                              Get.off(const RoomPage());
                            } else {
                              Get.snackbar(
                                  "Unable to Login with Google", result,
                                  duration: const Duration(seconds: 5),
                                  barBlur: 0,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white);
                            }
                          });
                        },
                        text: "Login with Google",
                        backgroundColor: Colors.red,
                        image: const Image(
                          image: AssetImage('assets/google.png'),
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 18),
                      child: RoundedButton(
                        outlined: false,
                        onPressed: () {
                          Get.to(() => const RoomPage());
                          // AuthenticationHelper()
                          //     .signInWithFacebook()
                          //     .then((result) {
                          //     if (result == null) {
                          //       Get.off(const RoomPage());
                          //     } else {
                          //       // print(result);
                          //       ScaffoldMessenger.of(context)
                          //           .showSnackBar(SnackBar(
                          //         content: Text(
                          //           result,
                          //           style: const TextStyle(fontSize: 16),
                          //         ),
                          //       ));
                          //     }
                          //   });
                        },
                        text: "Login with Facebook",
                        backgroundColor: Colors.blue,
                        icon: Icons.facebook,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle:
                            const TextStyle(fontSize: 16, letterSpacing: 2),
                      ),
                      onPressed: () => {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          elevation: 4,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          builder: (BuildContext context) {
                            return Signup();
                          },
                        ),
                      },
                      child: const Text('SIGN UP WITH EMAIL'),
                    ),
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
