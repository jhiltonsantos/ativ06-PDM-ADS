import 'dart:async';
import 'package:flutter/material.dart';
import 'package:quizz_flutter/data/dart_questions.dart';
import 'package:quizz_flutter/domain/question.dart';
import 'package:quizz_flutter/pages/quiz_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timer;

  _goNextScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const QuizPage()));
  }

  _startDelay() {
    _timer = Timer(const Duration(seconds: 6), _goNextScreen);
  }

  late DataQuestions data;

  Future<int> addQuestions() async {
    Question question1 = const Question(
        id: 0,
        question: 'A gestação dos cavalos-marinhos é feita pelos machos.',
        answer: 1);
    List<Question> listQuestions = [question1];
    return await data.insertQuestion(listQuestions);
  }

  @override
  void initState() {
    _startDelay();
    super.initState();
    data = DataQuestions();
    data.initializeDB().whenComplete(() async {
      await addQuestions();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black45,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SafeArea(child: SizedBox(height: 50)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ],
        ));
  }
}
