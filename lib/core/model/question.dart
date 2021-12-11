// TODO Implement this library.

class Question {
  List<String> tags;
  bool answered;
  int view_count;
  int answer_count;
  int score;
  int last_activity_date;
  int creation_date;
  int id;
  String link;
  String title;
  String body;

  Question(
      {required this.id,
      required this.tags,
      required this.answered,
      required this.view_count,
      required this.answer_count,
      required this.score,
      required this.last_activity_date,
      required this.creation_date,
      required this.link,
      required this.title,
      required this.body});
}
