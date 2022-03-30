import 'package:flutter/material.dart';
import 'package:quizz_desafio/database/dao/questions_dao.dart';
import 'package:quizz_desafio/domain/question.dart';
import 'package:quizz_desafio/pages/quiz_page.dart';

void main() {
  runApp(const QuizzDesafio());
  QuestionsDAO questionsDAO = QuestionsDAO();
  questionsDAO.save(Question(1, 'A gestação dos cavalos-marinhos é feita pelos machos.', 1));
  questionsDAO.save(Question(2, 'Por causa do tamanho, as girafas ficam o tempo todo em pé e só se deitam quando vão dar à luz.', 0));
  questionsDAO.save(Question(3, 'Os ornitorrincos são os únicos mamíferos venenosos que se tem notícia.', 0));
  questionsDAO.save(Question(4, 'Os louva-a-deus são capazes de capturar aranhas, lagartos e até ratos.', 1));
  questionsDAO.save(Question(5, 'Apesar de serem os mais famosos, os morcegos não são os únicos mamíferos capazes de voar.', 0));
  questionsDAO.save(Question(6, 'Existe uma espécie de pássaro que fica voando por até dez meses sem parar.', 1));
  questionsDAO.save(Question(7, 'Algumas arraias conseguem dar saltos de até três metros de altura.', 1));
  questionsDAO.save(Question(8, 'Os beija-flores são excelentes voadores, mas também conseguem usar suas patas para caminhar no solo.', 0));
  questionsDAO.save(Question(9, 'Um bicho-preguiça possui mais vértebras cervicais que um elefante ou uma girafa.', 1));
  questionsDAO.save(Question(10, 'Os golfinhos usam as toxinas liberadas pelos baiacus para ficarem doidões.', 1));
}

class QuizzDesafio extends StatelessWidget {
  const QuizzDesafio ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}