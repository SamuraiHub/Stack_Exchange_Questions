import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:stack_exchange_questions/core/api/questions_api_provider.dart';
import 'package:stack_exchange_questions/core/mapper/questions_mapper.dart';
import 'package:stack_exchange_questions/core/network/dio_network_client.dart';
import 'package:stack_exchange_questions/core/network/i_network_client.dart';
import 'package:stack_exchange_questions/core/repository/questions_repository.dart';

final sl = GetIt.instance;

Future<void> registerServiceLocator() async {
  registerNetworkClient();
  registerApi();
  registerRepository();
  registerMapper();
}

void registerNetworkClient() {
  sl.registerLazySingleton<INetworkClient>(() {
    var client = DioNetworkClient(
        options: BaseOptions(
            baseUrl:
                'https://api.stackexchange.com/2.3/questions?pagesize=100&order=desc&sort=creation&site=stackoverflow&filter=!nKzQUR3Egv'));
    return client;
  }, instanceName: 'Questions');
}

void registerApi() {
  sl.registerLazySingleton<QuestionsApiProvider>(() {
    return QuestionsApiProvider(sl.get(instanceName: 'Questions'));
  });
}

void registerRepository() {
  sl.registerLazySingleton<QuestionsRepository>(() {
    return QuestionsRepository(sl.get(), sl.get());
  });
}

void registerMapper() {
  sl.registerLazySingleton<QuestionMapper>(() => QuestionMapper());
}
