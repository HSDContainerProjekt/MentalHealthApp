import 'package:flutter/material.dart';
import 'package:path/path.dart';

class FriendPersonalinformationWidget extends StatelessWidget {
  final String textFieldTitle;
  final String textFieldValue;
  const FriendPersonalinformationWidget(
      this.textFieldTitle, this.textFieldValue,
      {super.key});

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 9, bottom: 9),
            width: 200,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1.0))),
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(textFieldValue, style: TextStyle(fontSize: 20),))),
        Align(
            alignment: Alignment.topLeft,
            child: (Text(
              textFieldTitle,
            )))
      ],
    );
  }
}
