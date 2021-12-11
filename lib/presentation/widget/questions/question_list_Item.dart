import 'package:flutter/material.dart';

class QuestionListItem extends StatelessWidget {
  String QuestionTitle;
  Function() onTab;

  QuestionListItem(this.QuestionTitle, this.onTab);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: const EdgeInsets.fromLTRB(2, 2, 2, 0),
      child: Card(
        elevation: 2.0,
        color: Colors.grey[100],
        child: ListTile(
          title: Text(QuestionTitle,
              style: TextStyle(fontSize: 15, color: Colors.lightBlue),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          onTap: () {
            this.onTab();
          },
        ),
      ),
    );
  }
}
