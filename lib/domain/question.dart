class Question {
  final int id;
  final String question;
  final int answer;

  const Question(
      {required this.id, required this.question, required this.answer});

  Map<String, dynamic> toMap() {
    return {'id': id, 'question': question, 'answer': answer};
  }

  Question.fromMap(Map<String, dynamic> q)
      : id = q['id'],
        question = q['question'],
        answer = q['answer'];

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answer: $answer';
  }
}
