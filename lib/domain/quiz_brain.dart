import 'dart:math';
import '../data/dart_questions.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _countQuestions = 0;

  late DataQuestions data;

  void nextQuestion(int question) {
    if (isFinished() == false) {
      _questionNumber = question;
    }
    _countQuestions++;
  }

  int nextRandomQuestion()  {
    int value = data.countLinesTable() as int;
    return Random().nextInt(value - 1);
  }

  Future<String> getQuestionText(int id) {
    return data.selectQuestion(id);
  }

  Future<int> getCorrectAnswer(int id) {
    return data.selectAnswers(id);
  }

  bool isFinished() {
    if (_countQuestions >= 14) {
      _countQuestions = 0;
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    int value = data.countLinesTable() as int;
    _questionNumber = Random().nextInt(value - 1);
  }
}
