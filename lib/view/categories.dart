import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/quiz_provider.dart';
import 'package:quizap/controller/room_connection.dart';
import 'package:quizap/model/category.dart';
import 'package:quizap/model/question.dart';
import 'package:quizap/view/custom_widgets/topic_button.dart';
import 'package:quizap/view/questions.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<Category> futureCategories;
  String? roomCode;

  late bool isCreator;

  @override
  void initState() {
    super.initState();
    futureCategories = QuizProvider().getCategories();
    roomCode = Get.arguments['roomCode'].toString();
    isCreator = Get.arguments['isCreator'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Choose a Topic to start',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            FutureBuilder<Category>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // return Text(snapshot.data!.triviaCategories!.length.toString());
                  return Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      children: snapshot.data!.triviaCategories!
                          .map(
                            (TriviaCategories e) => TopicButton(
                                onPressed: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    builder: (ctx) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      );
                                    },
                                    context: context,
                                  );
                                  QuizProvider()
                                      .getQuestionsFor(topicId: e.id!)
                                      .then((value) {
                                    RoomConnection()
                                        .addQuestionsToRoom(
                                            roomCode: roomCode!,
                                            questions: value)
                                        .then((val) {
                                      if (val) {
                                        RoomConnection()
                                            .getRoomQuestions(
                                                roomCode: roomCode!)
                                            .then((res) {
                                          Navigator.of(context).pop();
                                          Question questions =
                                              Question.fromJson(
                                                  res.docs.first.data());
                                          final args = {
                                            "questions": questions,
                                            "isCreator": isCreator,
                                            "roomCode": roomCode
                                          };
                                          Get.to(() => const QuestionsPage(),
                                              arguments: args);
                                        });
                                      }
                                    });
                                  });
                                },
                                name: e.name!),
                          )
                          .toList(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
