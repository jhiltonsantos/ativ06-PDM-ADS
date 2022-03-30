import 'package:path/path.dart';
import 'package:quizz_desafio/database/dao/questions_dao.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'quizz.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute(QuestionsDAO.tableSql);
    },
    version: 1,
    onDowngrade: onDatabaseDowngradeDelete,

  );
}
