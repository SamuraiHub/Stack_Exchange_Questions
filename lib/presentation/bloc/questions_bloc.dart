import 'package:bloc/bloc.dart';
import 'package:stack_exchange_questions/core/model/question.dart';
import 'package:stack_exchange_questions/core/repository/questions_repository.dart';
import 'package:stack_exchange_questions/presentation/bloc/questions_event.dart';
import 'package:stack_exchange_questions/presentation/bloc/questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionsRepository questionsRepo;
  int page = 1;
  bool isFetching = false;

  QuestionsBloc(this.questionsRepo) : super(QuestionsLoading());

  @override
  Stream<QuestionsState> mapEventToState(QuestionsEvent event) async* {
    if (event is QuestionsInitialLoad) {
      yield QuestionsLoading();
      yield await _proceedToLoad();
    } else if (event is QuestionsLoadNext) {
      page++;
      yield QuestionsLoading();
      yield await _proceedToLoad();
    } else if (event is QuestionsRestart) {
      page = 1;
      yield QuestionsLoading();
      yield await _proceedToLoad();
    }
  }

  Future<QuestionsState> _proceedToLoad() async {
    var result = await questionsRepo.getQuestions(page);

    return result.fold((exception) => QuestionsError(exception), (questions) {
      return QuestionsLoaded(questions);
    });
  }
}
