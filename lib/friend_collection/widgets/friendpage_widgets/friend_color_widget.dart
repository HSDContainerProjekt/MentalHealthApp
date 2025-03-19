import 'package:flutter/material.dart';

class FriendColorWidget extends StatelessWidget {
  final IconData passedIcon;
  final String iconText;
  final Color color;
  const FriendColorWidget(this.passedIcon, this.iconText, this.color,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(iconText),
      Container(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black, width: 2.0),
        ),
        child: Icon(passedIcon)
          )
    ]);
  }
}
