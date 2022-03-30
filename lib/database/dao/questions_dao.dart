import 'package:quizz_desafio/database/app_database.dart';
import 'package:quizz_desafio/domain/question.dart';
import 'package:sqflite/sqflite.dart';

class QuestionsDAO {

  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_question TEXT, '
      '$_answer INTEGER)';

  static const String _tableName = 'questions';
  static const String _id = 'id';
  static const String _question = 'question';
  static const String _answer = 'answer';
  
  Future<int> save(Question question) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> questionMap = {};
    questionMap[_id] = question.id;
    questionMap[_question] = question.question;
    questionMap[_answer] = question.answer;
    return db.insert(_tableName, questionMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }
  
  Future<List<Question>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Question> questions = [];
    for (Map<String, dynamic> row in result) {
      final Question question = Question(row[_id], row[_question], row[_answer]);
      questions.add(question);
    }
    return questions;
  }
  
  Future<int> countLinesTable() async {
    final Database db = await getDatabase();
    int countLines = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM questions'))!;
    return countLines;
  }
}