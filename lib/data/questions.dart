import 'package:quiz_app/models/quiz_question.dart';

const questions = [
  QuizQuestion(
    'Який оператор використовується для null-безпечного доступу до властивостей в Dart?',
    [
      '?.',
      '!!',
      '??',
      '->',
    ],
  ),
  QuizQuestion(
    'Як правильно оголосити константну змінну в Dart?',
    [
      'final name = "value"',
      'var name = "value"',
      'dynamic name = "value"',
      'string name = "value"',
    ],
  ),
  QuizQuestion(
    'Який тип даних в Dart використовується за замовчуванням, якщо значення не присвоєно?',
    [
      'null',
      'void',
      'undefined',
      '0',
    ],
  ),
  QuizQuestion(
    'Як називається спеціальний конструктор в Dart для створення іменованих параметрів?',
    [
      'named constructor',
      'default constructor',
      'factory constructor',
      'private constructor',
    ],
  ),
  QuizQuestion(
    'Яке ключове слово використовується для створення асинхронної функції в Dart?',
    [
      'async',
      'await',
      'future',
      'sync',
    ],
  ),
  QuizQuestion(
    'Який модифікатор доступу використовується в Dart для приватних членів класу?',
    [
      '_',
      'private',
      '#',
      'protected',
    ],
  ),
];