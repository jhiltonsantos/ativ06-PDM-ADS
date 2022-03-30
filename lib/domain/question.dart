class Question {
  final int id;
  final String question;
  final int answer;

  Question(this.id, this.question, this.answer);

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answer: $answer';
  }
}
