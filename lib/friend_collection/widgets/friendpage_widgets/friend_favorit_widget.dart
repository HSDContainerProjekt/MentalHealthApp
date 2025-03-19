import 'package:flutter/material.dart';

class FriendFavoritWidget extends StatelessWidget {
  final String textFieldTitle;
  final String textFieldValue;

  const FriendFavoritWidget(this.textFieldTitle, this.textFieldValue,
      {super.key});

  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(textFieldTitle),
        Container(
          width: 200,
          decoration: BoxDecoration(
              border:
                  Border(bottom: BorderSide(color: Colors.black, width: 1.0))),
          child: Text(textFieldValue),
        )
      ],
    );
  }
}
