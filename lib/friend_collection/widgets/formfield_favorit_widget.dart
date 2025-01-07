import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormfieldFavoritWidget extends StatefulWidget {
  final String textFieldTitle;
  final String textFieldValue; 
  final String textFieldHint;
  const FormfieldFavoritWidget(this.textFieldTitle, this.textFieldValue, this.textFieldHint, {super.key});

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
          onChanged: (value) => print(value), 
          keyboardType: TextInputType.phone,
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