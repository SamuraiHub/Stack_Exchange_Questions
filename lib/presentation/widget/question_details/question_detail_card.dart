import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class QuestionDetailCard extends StatelessWidget {
  const QuestionDetailCard(
      {Key? key, required this.name, required this.content})
      : super(key: key);
  final String name;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Text(
                name,
                style: TextStyle(fontSize: 15),
              ),
            ),
            Expanded(
              child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  color: Colors.grey[100],
                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: SelectableText(
                    content,
                    style: TextStyle(fontSize: 15),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
