import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';

class FormfieldPersonalinformationWidget extends StatefulWidget {
  final String textFieldTitle;
  final String textFieldValue;
  final String databaseField;
  const FormfieldPersonalinformationWidget(
      this.textFieldTitle, this.textFieldValue, this.databaseField,
      {super.key});

  @override
  State<FormfieldPersonalinformationWidget> createState() =>
      _FormfieldPersonalinformationWidgetState();
}

class _FormfieldPersonalinformationWidgetState
    extends State<FormfieldPersonalinformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderTextField(
          name: widget.textFieldTitle,
          onChanged: (value) => DatabaseOperation().saveAndTryToUpdateString(widget.databaseField,value ?? ""),
          keyboardType: TextInputType.text,
          autocorrect: false,
          initialValue: widget.textFieldValue,
          decoration:
              InputDecoration(constraints: BoxConstraints(maxWidth: 200.0)),
        ),
        Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.textFieldTitle,
            ))
      ],
    );
  }
}
