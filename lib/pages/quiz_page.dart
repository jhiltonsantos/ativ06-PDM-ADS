import 'package:flutter/material.dart';
import 'package:quizz_flutter/domain/quiz_brain.dart';
import 'package:quizz_flutter/pages/result_page.dart';
import 'package:quizz_flutter/resources/build_button.dart';
import 'package:quizz_flutter/resources/icons_answer.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

enum Answer { TRUE, FALSE, MAYBE }

QuizBrain quizBrain = QuizBrain();

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int countRightAnswers = 0;
  int countAnswers = 14;
  int countMaybe = 0;
  List<int> questions = [0];

  void checkAnswer(Answer userPickedAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        quizBrain.reset();
        scoreKeeper = [];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(
                      correctAnswers: countRightAnswers,
                      countAnswers: countAnswers,
                    )));
      } else {
        if (userPickedAnswer == Answer.MAYBE) {
          scoreKeeper.add(const Icon(
            Icons.question_mark,
            color: Colors.blue,
          ));
          countMaybe++;
        } else {
          if (correctAnswer) {
            if (userPickedAnswer == Answer.TRUE) {
              scoreKeeper.add(iconTrue());
              countRightAnswers++;
            } else {
              scoreKeeper.add(iconFalse());
            }
          } else {
            if (userPickedAnswer == Answer.FALSE) {
              scoreKeeper.add(iconTrue());
              countRightAnswers++;
            } else {
              scoreKeeper.add(iconFalse());
            }
          }
        }
      }
      nextQuestion();
    });
  }

  void nextQuestion () {
    int valueQuestion = quizBrain.nextRandomQuestion();
    for (var question in questions) {
      if (valueQuestion == question) {
        setState(() {
          nextQuestion();
        });

      }
    }
    quizBrain.nextQuestion(valueQuestion);
    questions.add(valueQuestion);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    quizBrain.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: buildButton(Colors.green, Colors.greenAccent,
                      'Verdadeiro', () => checkAnswer(Answer.TRUE))),
            ),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: buildButton(Colors.red, Colors.orangeAccent, 'Falso',
                      () => checkAnswer(Answer.FALSE))),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: buildButton(Colors.blue, Colors.deepPurpleAccent, 'Talvez',
                    () => checkAnswer(Answer.MAYBE)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: scoreKeeper.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: scoreKeeper,
                        ),
                        Row(
                          children: [
                            Text('$countRightAnswers/$countAnswers',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold))
                          ],
                        )
                      ],
                    )
                  : const Icon(null),
            ),
          ],
        ),
      ),
    );
  }
}