import 'package:flutter/material.dart';
import 'package:quizz_flutter/domain/question.dart';
import 'package:quizz_flutter/pages/quiz_page.dart';
import 'package:quizz_flutter/pages/splash_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() async {
  runApp(const Quizzler());
}

class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: SplashPage(),
          ),
        ),
      ),
    );
  }
}
