import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class StartScreen extends StatelessWidget {
  const StartScreen(this.startQuiz,{super.key});

  final void Function() startQuiz;


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          const SizedBox(
            height: 80,
          ),
          Text(
            'Простий тест про Dart!',
            style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 237, 223, 252),
                  fontSize: 24,
                  ),
          ),
          const SizedBox(height: 30,),
          OutlinedButton.icon(
            onPressed: startQuiz,
            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
            icon: const Icon(Icons.arrow_right_alt),
            label: const Text('Розпочати Тест'),
          )
        ],
      ),
    );
  }
}
