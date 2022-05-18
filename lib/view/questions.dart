import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/authentication.dart';
import 'package:quizap/model/question.dart';
import 'package:quizap/view/custom_widgets/countdown_bar.dart';
import 'package:quizap/view/custom_widgets/rounded_button.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:quizap/view/final_waiting.dart';
import 'package:quizap/view/result.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({Key? key}) : super(key: key);

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState
    extends State<QuestionsPage> /* with SingleTickerProviderStateMixin */ {
  /*
    Dropping Timer. Timer adds like 2x more complexity to the whole app.
    In order to decouple the setState of AnimationController,
    which updates ProgressBar thousands of time per second, 
    we must extract it to its child component.
    In order to timer to sync between its child component
    with parent component (to go to next question after timer expires or
    after player chooses an option), PageController and AnimationController
    must be in same non-component (or non-widget) singleton class with 
    its instance being used in both child and parent component. 
    Only this enables Timer and ViewPager sync. 
  */

  // late AnimationController controller;

  Color first = Colors.green;
  Color second = Colors.red;

  RxInt currentScore = 0.obs;
  RxInt currentQuestionIndex = 0.obs;

  bool isSelected = false;

  final PageController pageController = PageController();

  late List<Results> allQuestions;

  List<List<String>> allOptions = [];

  final unescape = HtmlUnescape();

  late bool isCreator;

  late String roomCode;

  @override
  void initState() {
    // controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 10),
    // )..addListener(() {
    //     setState(() {});
    //   });
    // controller.reverse(from: 10.0);
    Question ques = Get.arguments['questions'];
    isCreator = Get.arguments['isCreator'];
    roomCode = Get.arguments['roomCode'];
    allQuestions = ques.results!;
    allQuestions.forEach((element) {
      List<String> ans = element.incorrectAnswers!;
      ans.add(element.correctAnswer!);
      ans.shuffle();
      allOptions.add(ans);
    });
    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  void selection(
      {required int questionIndex, required int selectedAnswerIndex}) {
    setState(() {
      isSelected = true;
      if (allQuestions.elementAt(questionIndex).correctAnswer ==
          allOptions.elementAt(questionIndex).elementAt(selectedAnswerIndex)) {
        currentScore += 1;
      }
      // controller.reset();
      // controller.reverse(from: 10);
      // if (!isSelected) {
      //   controller.stop();
      // } else {
      //   controller.stop(canceled: true);
      //   controller.forward(from: 10);
      // }
    });
    Timer(const Duration(seconds: 2), () {
      if (currentQuestionIndex.value == allQuestions.length - 1) {
        final args = {
          "score": currentScore.value,
          "isCreator": isCreator,
          "roomCode": roomCode
        };
        Get.to(() => const FinalWaitingPage(), arguments: args);
      } else {
        setState(() {
          isSelected = false;
        });
        pageController.nextPage(
            duration: const Duration(milliseconds: 250), curve: Curves.ease);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "$currentScore/10",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allQuestions.length,
              itemBuilder: (context, index) {
                currentQuestionIndex.value = index;
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        unescape
                            .convert(allQuestions.elementAt(index).question!),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    ...List.generate(
                      allOptions.elementAt(index).length,
                      (idx) => Padding(
                        padding: const EdgeInsets.all(20),
                        child: RoundedButton(
                          outlined: true,
                          onPressed: !isSelected
                              ? () {
                                  selection(
                                      questionIndex: index,
                                      selectedAnswerIndex: idx);
                                }
                              : () {},
                          text: unescape.convert(
                              allOptions.elementAt(index).elementAt(idx)),
                          textColor: Colors.black,
                          backgroundColor: (isSelected &&
                                  (allOptions.elementAt(index).elementAt(idx) ==
                                      allQuestions
                                          .elementAt(index)
                                          .correctAnswer))
                              ? first
                              : (isSelected ? second : Colors.black),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
