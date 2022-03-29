import 'dart:math';

import 'question.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _countQuestions = 0;
  List<int> questions = [];

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

  void nextQuestion(int question) {
    if (isFinished() == false) {
      _questionNumber = question;

    }
    _countQuestions++;
  }

  int nextRandomQuestion() {
    return Random().nextInt(_questionBank.length - 1);
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
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
    _questionNumber = Random().nextInt(_questionBank.length - 1);
  }
}
