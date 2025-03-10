import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'dart:math';

import 'package:mental_health_app/friend_collection/database/friend_db.dart';

class CustomColorWidget extends StatefulWidget {
  final IconData passedIcon;
  final String iconText;
  const CustomColorWidget(this.passedIcon, this.iconText, {super.key});

  @override
  State<CustomColorWidget> createState() => _CustomColorPicker();
}

class _CustomColorPicker extends State<CustomColorWidget> {
  Color pickedColor = Color.fromARGB(
      255, Random().nextInt(255), Random().nextInt(255), Random().nextInt(255));

  void changeColor(newColor) {
    setState(() {
      pickedColor = newColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(widget.iconText),
      GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  width: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlockPicker(
                        pickerColor: pickedColor, //default color
                        onColorChanged: (Color color) {
                          //on the color picked
                          changeColor(color);
                          FriendDB().saveColor(widget.passedIcon, color.value);
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: pickedColor,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: Icon(widget.passedIcon),
          ))
    ]);
  }
}
