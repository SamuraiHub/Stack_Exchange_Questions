// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questions_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionsList _$QuestionsListFromJson(Map<String, dynamic> json) {
  return QuestionsList(
    (json['items'] as List<dynamic>)
        .map((e) => Questions.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$QuestionsListToJson(QuestionsList instance) =>
    <String, dynamic>{
      'items': instance.questions,
    };

Questions _$QuestionsFromJson(Map<String, dynamic> json) {
  return Questions(
    json['question_id'] as int,
    json['tags'].cast<String>(),
    json['is_answered'] as bool,
    json['view_count'] as int,
    json['answer_count'] as int,
    json['score'] as int,
    json['last_activity_date'] as int,
    json['creation_date'] as int,
    json['link'] as String,
    json['title'] as String,
    json['body'] as String,
  );
}

Map<String, dynamic> _$QuestionsToJson(Questions instance) => <String, dynamic>{
      'question_id': instance.id,
      'tags': instance.tags,
      'is_answered': instance.answered,
      'view_count': instance.view_count,
      'answer_count': instance.answer_count,
      'score': instance.score,
      'last_activity_date': instance.last_activity_date,
      'creation_date': instance.creation_date,
      'link': instance.link,
      'title': instance.title,
      'body': instance.body,
    };
