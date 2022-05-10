import 'dart:convert';

import 'package:quizap/model/category.dart';
import 'package:quizap/model/question.dart';
import 'package:http/http.dart' as http;

class QuizProvider {
  static const String _baseDomain = 'https://opentdb.com/';
  static const String _category = 'api_category.php';

  Future<Category> getCategories() async {
    final response = await http.get(Uri.parse(_baseDomain + _category));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Category.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load categories.');
    }
  }
}
