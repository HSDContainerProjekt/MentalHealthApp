import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';

class FormfieldFavoritWidget extends StatefulWidget {
  final String textFieldTitle;
  final String textFieldValue; 
  final String textFieldHint;
  final String databaseField;
  const FormfieldFavoritWidget(this.textFieldTitle, this.textFieldValue, this.textFieldHint, this.databaseField,{super.key});

  @override
  State<FormfieldFavoritWidget> createState() => _FormfieldFavoritWidgetState();
}

class _FormfieldFavoritWidgetState extends State<FormfieldFavoritWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(widget.textFieldTitle),
        FormBuilderTextField(
          name: widget.textFieldTitle,
          onChanged: (value) => DatabaseOperation().saveAndTryToUpdateString(widget.databaseField,value ?? ""), 
          keyboardType: TextInputType.text,
          autocorrect: false,    
          initialValue: widget.textFieldValue,        
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: 200.0)
          ),      
        )
      ],
    );
  }
}