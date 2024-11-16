import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class ResultsHistoryScreen extends StatefulWidget {
  const ResultsHistoryScreen({super.key});

  @override
  State<ResultsHistoryScreen> createState() => _ResultsHistoryScreenState();
}

class _ResultsHistoryScreenState extends State<ResultsHistoryScreen> {
  List<Map<String, dynamic>> _quizResults = [];

  @override
  void initState() {
    super.initState();
    _loadResults();
  }

  Future<void> _loadResults() async {
    final prefs = await SharedPreferences.getInstance();
    final results = prefs.getStringList('quiz_results') ?? [];
    setState(() {
      _quizResults = results
          .map((result) => jsonDecode(result) as Map<String, dynamic>)
          .toList()
          .reversed
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 78, 13, 151),
              Color.fromARGB(255, 107, 15, 168),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
              title: Text(
                'Історія Результатів',
                style: GoogleFonts.notoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            Expanded(
              child: _quizResults.isEmpty
                  ? Center(
                      child: Text(
                        'Немає збережених результатів.',
                        style: GoogleFonts.notoSans(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _quizResults.length,
                      itemBuilder: (context, index) {
                        final result = _quizResults[index];
                        final dateTime = DateTime.parse(result['dateTime']);
                        final totalQuestions = result['totalQuestions'];
                        final correctQuestions = result['correctQuestions'];
                        final percentageScore = ((correctQuestions / totalQuestions) * 100).toStringAsFixed(1);

                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          color: const Color.fromARGB(255, 94, 26, 162),
                          child: ListTile(
                            title: Text(
                              'Дата: ${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}',
                              style: GoogleFonts.notoSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              'Правильних відповідей: $correctQuestions/$totalQuestions\nВідсоток правильних: $percentageScore%',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
