import 'package:quiz_app/data/questions.dart';

class QuizResult {
  final DateTime dateTime;
  final List<String> chosenAnswers;
  final List<Map<String, Object>> summaryData;
  final int totalQuestions;
  final int correctQuestions;

  QuizResult({
    required this.dateTime,
    required this.chosenAnswers,
    required this.summaryData,
    required this.totalQuestions,
    required this.correctQuestions,
  });

  double get percentageScore => (correctQuestions / totalQuestions) * 100;

  static List<Map<String, Object>> generateSummaryData(List<String> chosenAnswers) {
    if (chosenAnswers.length != questions.length) {
      throw Exception('Number of answers does not match number of questions');
    }

    final List<Map<String, Object>> summary = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  Map<String, dynamic> toJson() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'chosenAnswers': chosenAnswers,
      'summaryData': summaryData.map((map) => Map<String, dynamic>.from(map)).toList(),
      'totalQuestions': totalQuestions,
      'correctQuestions': correctQuestions,
    };
  }

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      dateTime: DateTime.parse(json['dateTime']),
      chosenAnswers: List<String>.from(json['chosenAnswers']),
      summaryData: (json['summaryData'] as List).map((item) => 
        Map<String, Object>.from(item as Map)).toList(),
      totalQuestions: json['totalQuestions'] as int,
      correctQuestions: json['correctQuestions'] as int,
    );
  }

  factory QuizResult.fromChosenAnswers(List<String> chosenAnswers) {
    final summaryData = generateSummaryData(chosenAnswers);
    final correctQuestions = summaryData
        .where((data) => data['user_answer'] == data['correct_answer'])
        .length;

    return QuizResult(
      dateTime: DateTime.now(),
      chosenAnswers: chosenAnswers,
      summaryData: summaryData,
      totalQuestions: chosenAnswers.length,
      correctQuestions: correctQuestions,
    );
  }
}