import 'package:flutter/material.dart';
import 'package:quizz_desafio/database/dao/questions_dao.dart';
import 'package:quizz_desafio/domain/question.dart';
import 'package:quizz_desafio/pages/result_page.dart';
import 'package:quizz_desafio/resources/build_button.dart';
import 'package:quizz_desafio/resources/icons_answer.dart';

enum Answer { TRUE, FALSE, MAYBE }

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuestionsDAO _daoQuestion = QuestionsDAO();

  int questionNumber = 0;
  List<Icon> scoreKeeper = [];
  late int correctAnswer;
  late double percentAnswers;
  int countQuestions = 0;
  int countMaybe = 0;
  int countRightAnswers = 0;



  bool isFinished() {
    if (countQuestions >= 9) {
      countQuestions = 0;
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    questionNumber = 0;
  }

  void nextQuestion() {
    questionNumber < 9 ? questionNumber++ : reset();
  }

  void checkAnswer(Answer userPickedAnswer) {
    setState(() {
      if (isFinished()) {
        reset();
        scoreKeeper = [];
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResultPage(
                  correctAnswers: countRightAnswers,
                  percent: percentAnswers.toStringAsFixed(1),
                )));
      } else {
        if (userPickedAnswer == Answer.MAYBE) {
          scoreKeeper.add(iconMaybe());
          countMaybe++;
        } else {
          if (correctAnswer == 0) {
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
      percentAnswers = (countRightAnswers / 9) * 100;
      nextQuestion();
      countQuestions++;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: FutureBuilder<List<Question>>(
        future: Future.delayed(const Duration(seconds: 1))
            .then((value) => _daoQuestion.findAll()),

        builder: (context, snapshot) {
          if (snapshot.data != null) {
            final List<Question> questions = snapshot.data as List<Question>;
            final question = questions[questionNumber];
            correctAnswer = question.answer;
            return SafeArea(
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
                        question.question,
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
                      child: buildButton(Colors.red, Colors.orangeAccent,
                          'Falso', () => checkAnswer(Answer.FALSE))),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: buildButton(Colors.blue, Colors.deepPurpleAccent,
                        'Talvez', () => checkAnswer(Answer.MAYBE)),
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
                          Text('${percentAnswers.toStringAsFixed(1)}%',
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
            ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
