import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../domain/question.dart';


class DataQuestions {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(await getDatabasesPath(), 'question.db'),
      onCreate: (db, version) {
        return db.execute('''
      CREATE TABLE questions (
        id INTERGER PRIMARY KEY,
        question TEXT NOT NULL,
        answer INTERGER NOT NULL
      )
      ''');
      },
      version: 1,
    );
  }

  Future<int> countLinesTable() async {
    final Database db = await initializeDB();
    int countLines = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM questions'))!;
    return countLines;
  }

  Future<int> insertQuestion(List<Question> questions) async {
    int result = 0;
    final Database db = await initializeDB();
    for(var question in questions) {
      result = await db.insert('questions', question.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return result;
  }

  Future<List<Question>> listQuestions() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('questions');
    return List.generate(maps.length, (i) {
      return Question(
          id: maps[i]['id'],
          question: maps[i]['question'],
          answer: maps[i]['answer']);
    });
  }

  Future<String> selectQuestion(int id) async {
    final Database db = await initializeDB();
    var result = await db.query("questions", where: "id = ", whereArgs: [id]);
    return Question.fromMap(result.first).question;
  }

  Future<int> selectAnswers(int id) async {
    final Database db = await initializeDB();
    var result = await db.query("questions", where: "id = ", whereArgs: [id]);
    return Question.fromMap(result.first).answer;
  }
}


/*
  final List<Question> _questionBank = [
    Question('A gestação dos cavalos-marinhos é feita pelos machos.', true),
    Question('Por causa do tamanho, as girafas ficam o tempo todo em pé e só se deitam quando vão dar à luz.', false),
    Question('Os ornitorrincos são os únicos mamíferos venenosos que se tem notícia.', false),
    Question('Os louva-a-deus são capazes de capturar aranhas, lagartos e até ratos.', true),
    Question('Apesar de serem os mais famosos, os morcegos não são os únicos mamíferos capazes de voar.', false),
    Question('Existe uma espécie de pássaro que fica voando por até dez meses sem parar.', true),
    Question('Algumas arraias conseguem dar saltos de até três metros de altura.', true),
    Question('Os beija-flores são excelentes voadores, mas também conseguem usar suas patas para caminhar no solo.', false),
    Question('Um bicho-preguiça possui mais vértebras cervicais que um elefante ou uma girafa.', true),
    Question('Os golfinhos usam as toxinas liberadas pelos baiacus para ficarem doidões.', true),
    Question('Orcas não são baleias, mas sim uma espécie de golfinho.', true),
    Question('Segurar um espirro pode até mesmo causar o rompimento de um vaso sanguíneo.', false),
    Question('Antigamente, costumava-se escovar os dentes com urina.', true),
    Question('Existem mais átomos no corpo humano do que estrelas no Universo.', true),
    Question('A asa de um mosquito se move 1000 vezes por segundo.', true),
    Question('Há mais bactérias em sua boca do que pessoas no planeta Terra.', true),
    Question('A chance de se ter uma pessoa com uma impressão digital igual a outra é a mesma de ganhar na loteria 50 vezes.', false),
    Question('Um estudo comprovou que a comida preferida dos ratos é queijo.', false),
    Question('O Pernalonga não é um coelho, mas sim uma espécie de lebre.', true),
    Question('Um polvo tem cinco corações', false),
    Question('O Brasil é o único país das Américas a ter a língua oficial do português', true),
    Question('Stephen Hawking recusou o título de cavaleiro da Rainha', true),
    Question('Napoleão tinha altura abaixo da média', false),
    Question('Varsóvia é a capital da Bulgária', false),
    Question('Japão e Rússia não assinaram um tratado de paz após a Segunda Guerra Mundial, então, tecnicamente, ainda estão em guerra', true),
    Question('A famosa frase “Penso, logo existo” foi dita por Platao.', false),
    Question('O chuveiro elétrico foi inventado no Brasil.', true),
    Question('Vaticano é o menor país do mundo.', true),
    Question('O livro mais vendido do mundo seguido da Biblia é O Pequeno Principe', false)
  ];

   */