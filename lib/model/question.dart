import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  int? responseCode;
  List<Results>? results;

  Question({this.responseCode, this.results});

  Question.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add( Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Question.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      )   : responseCode = snapshot.data()?["response_code"],
        results = snapshot.data()?["results"];

  Map<String, dynamic> toFirestore() {
    return {
      if (responseCode != null) "response_code": responseCode,
      if (results != null) "results": results,
    };
  }
}

class Results {
  String? category;
  String? type;
  String? difficulty;
  String? question;
  String? correctAnswer;
  List<String>? incorrectAnswers;

  Results(
      {this.category,
      this.type,
      this.difficulty,
      this.question,
      this.correctAnswer,
      this.incorrectAnswers});

  Results.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    type = json['type'];
    difficulty = json['difficulty'];
    question = json['question'];
    correctAnswer = json['correct_answer'];
    incorrectAnswers = json['incorrect_answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['type'] = this.type;
    data['difficulty'] = this.difficulty;
    data['question'] = this.question;
    data['correct_answer'] = this.correctAnswer;
    data['incorrect_answers'] = this.incorrectAnswers;
    return data;
  }

  Results.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      )   : category = snapshot.data()?["category"],
        type = snapshot.data()?["type"],
        difficulty = snapshot.data()?["difficulty"],
        question = snapshot.data()?["question"],
        correctAnswer = snapshot.data()?["correct_answer"],
        incorrectAnswers = snapshot.data()?["incorrect_answers"];

  Map<String, dynamic> toFirestore() {
    return {
      if (category != null) "category": category,
      if (type != null) "type": type,
      if (difficulty != null) "difficulty": difficulty,
      if (question != null) "question": question,
      if (correctAnswer != null) "correct_answer": correctAnswer,
      if (incorrectAnswers != null) "incorrect_answers": incorrectAnswers,
    };
  }
}
