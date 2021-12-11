import 'package:dartz/dartz.dart';
import 'package:stack_exchange_questions/core/model/question.dart';
import 'package:stack_exchange_questions/core/api/questions_api_provider.dart';
import 'package:stack_exchange_questions/core/mapper/questions_mapper.dart';

class QuestionsRepository {
  late QuestionsApiProvider _questionsApi;
  late QuestionMapper _mapper;

  QuestionsRepository(this._questionsApi, this._mapper);

  Future<Either<Exception, List<Question>>> getQuestions(int page) async {
    try {
      var result = await _questionsApi.getQuestions(page);
      var mappedResults = _mapper.toList(result.questions);
      return Right(mappedResults);
    } on Exception catch (exception) {
      return Left(exception);
    }
  }
}
