import 'package:dio/dio.dart';
import 'package:stack_exchange_questions/core/api/i_api_provider.dart';
import 'package:stack_exchange_questions/core/api/model/questions_list.dart';
import 'package:stack_exchange_questions/core/network/i_network_client.dart';

class QuestionsApiProvider extends IApiProvider {
  QuestionsApiProvider(INetworkClient client) : super(client);

  Future<QuestionsList> getQuestions(int page) async {
    try {
      var path = '';
      var res = await client.get(path, queryParameters: {'page': page});
      return QuestionsList.fromJson(res.data);
    } on DioError catch (exception) {
      throw exception;
    }
  }
}
