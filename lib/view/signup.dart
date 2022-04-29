import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';
import 'package:quizap/view/room.dart';

class Signup extends StatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  bool _obscureText = true;

  bool _isLoading = false;

  final _pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Sign up with email',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              // email
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  // initialValue: 'Input text',
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    email = val;
                  },
                ),
              ),

              // password
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  // initialValue: 'Input text',
                  controller: _pass,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                  ),
                  obscureText: _obscureText,
                  onSaved: (val) {
                    password = val;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some value.';
                    }
                    return null;
                  },
                ),
              ),

              // Confirm password
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(100.0),
                      ),
                    ),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value != _pass.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    top: 16,
                    left: 16,
                    right: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 16),
                child: RoundedButton(
                    outlined: false,
                    isLoading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        setState(() {
                          _isLoading = true;
                        });
                        AuthenticationHelper()
                            .signUp(email: email!, password: password!)
                            .then((result) {
                          setState(() {
                            _isLoading = false;
                          });
                          if (result == null) {
                            Get.offAll(() => RoomPage());
                          } else {
                            if (kDebugMode) {
                              print(result);
                            }
                            Get.snackbar("Unable to Signup", result,
                                duration: const Duration(seconds: 5),
                                barBlur: 0,
                                backgroundColor: Colors.red,
                                colorText: Colors.white);
                          }
                        });
                      }
                    },
                    text: "Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
