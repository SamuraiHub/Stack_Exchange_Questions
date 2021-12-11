import 'package:json_annotation/json_annotation.dart';

part 'questions_list.g.dart';

@JsonSerializable()
class QuestionsList {
  List<Questions> questions;

  QuestionsList(this.questions);

  factory QuestionsList.fromJson(Map<String, dynamic> json) =>
      _$QuestionsListFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsListToJson(this);
}

@JsonSerializable()
class Questions {
  @JsonKey(name: 'tags')
  List<String> tags;
  @JsonKey(name: 'is_answered')
  bool answered;
  @JsonKey(name: 'view_count')
  int view_count;
  @JsonKey(name: 'answer_count')
  int answer_count;
  @JsonKey(name: 'score')
  int score;
  @JsonKey(name: 'last_activity_date')
  int last_activity_date;
  @JsonKey(name: 'creation_date')
  int creation_date;
  @JsonKey(name: 'question_id')
  int id;
  @JsonKey(name: 'link')
  String link;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'body')
  String body;

  Questions(
      this.id,
      this.tags,
      this.answered,
      this.view_count,
      this.answer_count,
      this.score,
      this.last_activity_date,
      this.creation_date,
      this.link,
      this.title,
      this.body);

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionsToJson(this);
}
