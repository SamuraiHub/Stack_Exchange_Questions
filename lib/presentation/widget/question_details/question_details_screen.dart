import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:stack_exchange_questions/core/model/question.dart';
import 'package:stack_exchange_questions/presentation/widget/question_details/question_detail_card.dart';

class QuestionsDetailsScreen extends StatelessWidget {
  final Question question;

  QuestionsDetailsScreen(this.question);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Question Details"),
        centerTitle: true,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              QuestionDetailCard(name: "Title", content: question.title),
              QuestionDetailCard(
                  name: "View Count", content: question.view_count.toString()),
              QuestionDetailCard(
                  name: "Score", content: question.score.toString()),
              QuestionDetailCard(
                  name: "Answered", content: question.answered.toString()),
              QuestionDetailCard(
                  name: "Answer Count",
                  content: question.answer_count.toString()),
              QuestionDetailCard(
                  name: "Creation Date",
                  content: DateFormat('dd-MMMM-yyyy – hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          question.creation_date * 1000))),
              QuestionDetailCard(
                  name: "Last Acitvity Date",
                  content: DateFormat('dd-MMMM-yyyy – hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          question.last_activity_date * 1000))),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Body:',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.grey[100],
                        margin:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        child: Html(data: question.body, style: {
                          'p': Style(fontSize: FontSize(15)),
                        }),
                      ),
                    ]),
              ),
              QuestionDetailCard(name: "Link", content: question.link),
              QuestionDetailCard(
                  name: "Tags", content: question.tags.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
