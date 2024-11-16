import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_result.dart';
import 'package:quiz_app/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/results_history_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.chosenAnswers, required this.restartQuiz});
  final void Function() restartQuiz;
  final List<String> chosenAnswers;

  Future<void> _saveResults() async {
    final result = QuizResult.fromChosenAnswers(chosenAnswers);
    final prefs = await SharedPreferences.getInstance();
    final resultJson = result.toJson();
    final existingResults = prefs.getStringList('quiz_results') ?? [];
    existingResults.add(jsonEncode(resultJson));
    await prefs.setStringList('quiz_results', existingResults);
  }

  @override
  Widget build(BuildContext context) {
    final quizResult = QuizResult.fromChosenAnswers(chosenAnswers);
    final summaryData = quizResult.summaryData;
    final numTotalQuestions = quizResult.totalQuestions;
    final numCorrectQuestions = quizResult.correctQuestions;

    _saveResults();

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ти відповів на $numCorrectQuestions з $numTotalQuestions питань правильно!',
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSans(
                color: const Color.fromARGB(255, 237, 223, 252),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            const SizedBox(
              height: 30,
            ),
            TextButton.icon(
              onPressed: restartQuiz,
              icon: const Icon(
                Icons.refresh_sharp,
                color: Colors.white,
              ),
              label: const Text(
                'Почати спочатку!',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton.icon(
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ResultsHistoryScreen()),
                );
              },
              label: const Text('Переглянути історію результатів', style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
