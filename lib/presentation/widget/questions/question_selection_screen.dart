import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_exchange_questions/core/di/service_locator.dart';
import 'package:stack_exchange_questions/core/model/question.dart';
import 'package:stack_exchange_questions/core/repository/questions_repository.dart';
import 'package:stack_exchange_questions/presentation/bloc/questions_bloc.dart';
import 'package:stack_exchange_questions/presentation/bloc/questions_event.dart';
import 'package:stack_exchange_questions/presentation/bloc/questions_state.dart';
import 'package:stack_exchange_questions/presentation/widget/question_details/question_details_screen.dart';
import 'package:stack_exchange_questions/presentation/widget/questions/question_list_Item.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  QuestionsScreenState createState() => QuestionsScreenState();
}

class QuestionsScreenState extends State<QuestionsScreen> {
  final List<Question> questions = [];
  bool offline = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuestionsBloc(sl.get<QuestionsRepository>())
        ..add(QuestionsInitialLoad()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('StackOverflow Questions'),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton<int>(
                itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                      new PopupMenuItem<int>(value: 1, child: Text('Refresh')),
                      new PopupMenuItem<int>(
                          value: 2,
                          child: Row(children: <Widget>[
                            Text("Offline"),
                            StatefulBuilder(
                                builder: (context, setStateSB) => Checkbox(
                                      value: offline,
                                      onChanged: (newValue) {
                                        setStateSB(() {
                                          offline = newValue!;
                                        });
                                        setState(() {
                                          offline = newValue!;
                                        });
                                      },
                                    )),
                          ])),
                    ],
                onSelected: (int value) {
                  setState(() {
                    if (value == 1) {
                      questions.clear();
                      QuestionsBloc(sl.get<QuestionsRepository>())
                        ..isFetching = true
                        ..add(QuestionsRestart());
                    } else if (value == 2) {
                      QuestionsBloc(sl.get<QuestionsRepository>())
                        ..isFetching = false;
                    }
                  });
                })
          ],
        ),
        body: QuestionsBody(questions, offline),
      ),
    );
  }
}

class QuestionsBody extends StatelessWidget {
  final List<Question> _questions;
  final bool offline;

  QuestionsBody(this._questions, this.offline);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<QuestionsBloc, QuestionsState>(
        listener: (context, QuestionsState) {
          if (QuestionsState is QuestionsLoading) {
            // show that the equestions are loading
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Loading Questions'),
              duration: Duration(seconds: 2),
            ));
          } else if (QuestionsState is QuestionsLoaded &&
              QuestionsState.items.isEmpty) {
            // if items are empty then show that there is no more questions
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('No more questions'),
                duration: Duration(seconds: 2)));
          } else if (QuestionsState is QuestionsError) {
            // show the error exception
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(QuestionsState.exception.toString()),
              duration: Duration(seconds: 10),
            ));
            context.read<QuestionsBloc>().isFetching = false;
          }
          return;
        },
        builder: (context, QuestionsState) {
          if (QuestionsState is QuestionsLoading && _questions.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else if (QuestionsState is QuestionsLoaded) {
            _questions.addAll(QuestionsState.items);
            context.read<QuestionsBloc>().isFetching = false;
          } else if (QuestionsState is QuestionsError && _questions.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<QuestionsBloc>()
                      ..isFetching = true
                      ..add(QuestionsRestart());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(QuestionsState.exception.toString(),
                    textAlign: TextAlign.center),
              ],
            );
          }
          return ListView.builder(
            controller: _scrollController
              ..addListener(() {
                if (_scrollController.offset ==
                        _scrollController.position.maxScrollExtent &&
                    !context.read<QuestionsBloc>().isFetching &&
                    !offline) {
                  context.read<QuestionsBloc>()
                    ..isFetching = true
                    ..add(QuestionsLoadNext());
                }
              }),
            itemBuilder: (context, index) =>
                QuestionListItem(_questions[index].title, () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          QuestionsDetailsScreen(_questions[index])));
            }),
            itemCount: _questions.length,
          );
        },
      ),
    );
  }
}
