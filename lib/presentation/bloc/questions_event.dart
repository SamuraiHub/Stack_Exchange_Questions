import 'package:equatable/equatable.dart';
import 'package:stack_exchange_questions/core/model/question.dart';

class QuestionsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuestionsInitialLoad extends QuestionsEvent {}

class QuestionsLoadNext extends QuestionsEvent {}

class QuestionsRestart extends QuestionsEvent {}
