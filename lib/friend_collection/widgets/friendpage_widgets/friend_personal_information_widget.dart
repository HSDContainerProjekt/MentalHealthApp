import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';

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
            width: 200,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 1.0))),
            child: Text(textFieldValue)),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              textFieldTitle,
            ))
      ],
    );
  }
}
