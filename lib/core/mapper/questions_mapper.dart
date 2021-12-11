import 'package:stack_exchange_questions/core/api/model/questions_list.dart';
import 'package:stack_exchange_questions/core/mapper/mapper.dart';
import 'package:stack_exchange_questions/core/model/question.dart';

class QuestionMapper extends Mapper<Questions, Question> {
  @override
  Questions from(Question? output) {
    throw UnimplementedError(); // Not used
  }

  @override
  Question to(Questions? input) {
    return Question(
        id: input?.id ?? 0,
        answer_count: input?.answer_count ?? 0,
        answered: input?.answered ?? false,
        creation_date: input?.creation_date ?? 0,
        last_activity_date: input?.last_activity_date ?? 0,
        score: input?.score ?? 0,
        tags: input?.tags ?? List<String>.empty(),
        view_count: input?.view_count ?? 0,
        title: input?.title ?? "",
        link: input?.link ?? "",
        body: input?.body ?? "");
  }
}
