import 'package:flutter/material.dart';

class FormfieldPersonalinformationWidget extends StatefulWidget {
  final String textFieldTitle;
  final String textFieldValue; 
  final String textFieldHint;
  const FormfieldPersonalinformationWidget(this.textFieldTitle, this.textFieldValue, this.textFieldHint, {super.key});

  @override
  State<FormfieldPersonalinformationWidget> createState() => _FormfieldPersonalinformationWidgetState();
}

class _FormfieldPersonalinformationWidgetState extends State<FormfieldPersonalinformationWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.text,
      autocorrect: false,
      decoration: InputDecoration(
        labelText: widget.textFieldTitle,
        constraints: BoxConstraints(maxWidth: 200.0)
      ),
      
    );
  }
}