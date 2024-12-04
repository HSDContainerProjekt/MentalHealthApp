import 'package:flutter/material.dart';

class BackButton extends IconButton {
  const BackButton({super.key, required super.onPressed, required super.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_rounded));
  }
}
