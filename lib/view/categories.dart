import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizap/controller/quiz_provider.dart';
import 'package:quizap/model/category.dart';
import 'package:quizap/view/custom_widgets/topic_button.dart';
import 'package:quizap/view/questions.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<Category> futureCategories;

  @override
  void initState() {
    super.initState();
    futureCategories = QuizProvider().getCategories();
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
                                  Get.to(() => const QuestionsPage());
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
