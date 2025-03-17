import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';
import 'dart:developer';

import 'package:mental_health_app/friend_collection/database/friend_db.dart';

class CustomColorWidget extends StatefulWidget {
  final IconData passedIcon;
  final String iconText;
  final Color? initialColor;
  const CustomColorWidget(this.passedIcon, this.iconText, this.initialColor,
      {super.key});

  @override
  State<CustomColorWidget> createState() => _CustomColorPicker();
}

class _CustomColorPicker extends State<CustomColorWidget> {
  late Color pickedColor;


  @override
  void initState(){
    super.initState();
    if (widget.initialColor == null) {
      pickedColor = Color.fromARGB(255, 21, 21, 200);
    } else {
      pickedColor = widget.initialColor!;
    }
  }

  void changeColor(Color color) {
    setState(() {
      pickedColor = color;
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
                        pickerColor: widget.initialColor, //default color
                        onColorChanged: (Color color) {
                          //on the color picked
                          changeColor(color);
                          DatabaseOperation().saveAndTryToUpdateColor(
                              widget.passedIcon, color.value);
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
