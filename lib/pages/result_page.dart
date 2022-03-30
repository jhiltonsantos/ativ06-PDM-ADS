import 'package:flutter/material.dart';
import 'package:quizz_desafio/pages/quiz_page.dart';
import 'package:quizz_desafio/resources/build_button.dart';

class ResultPage extends StatefulWidget {
  final int correctAnswers;
  final String percent;

  const ResultPage({Key? key, required this.correctAnswers, required this.percent}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  String textResult() {
    if (widget.correctAnswers < 4) {
      return 'Você foi mal, tente mais uma vez!!!';
    } else if (widget.correctAnswers < 6) {
      return 'Você foi bem, mas ainda pode melhorar!!!';
    } else if (widget.correctAnswers < 8) {
      return 'Você foi ótimo, faltou pouco para acertar todas!!!';
    } else {
      return 'Você foi excelente, acertou todas!!!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        textResult(),
                        style: const TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 36.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${widget.percent}% das questões estão corretas!",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26.0,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: buildButton(
                    Colors.blue, Colors.deepPurpleAccent, 'Tentar Novamente',
                        () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const QuizPage()));
                      });
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
