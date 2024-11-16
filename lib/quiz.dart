import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/start_screen.dart';
import 'package:quiz_app/results_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var currentScreen = 'start-screen';

  void changeScreen() {
    setState(() {
      currentScreen = 'questions-screen';
    });
  }

  void restartQuiz() {
    setState(() {
      currentScreen = 'start-screen';
      selectedAnswers = [];
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        currentScreen = 'results-screen';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme(),
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      home: Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 78, 13, 151),
                  Color.fromARGB(255, 107, 15, 168)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: currentScreen == 'start-screen'
                ? StartScreen(changeScreen)
                : currentScreen == 'results-screen'
                    ? ResultsScreen(
                        chosenAnswers: selectedAnswers,
                        restartQuiz: restartQuiz,
                      )
                    : QuestionsScreen(
                        onSelectAnswer: chooseAnswer,
                      )),
      ),
    );
  }
}
