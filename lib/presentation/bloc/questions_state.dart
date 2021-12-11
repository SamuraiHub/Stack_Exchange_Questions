import 'package:equatable/equatable.dart';
import 'package:stack_exchange_questions/core/model/question.dart';

class QuestionsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionsLoading extends QuestionsState {}

class QuestionsLoaded extends QuestionsState {
  final List<Question> items;

  QuestionsLoaded(this.items);

  @override
  List<Object?> get props => items;
}

class QuestionsError extends QuestionsState {
  final Exception exception;

  QuestionsError(this.exception);

  @override
  List<Object?> get props => [exception];
}
