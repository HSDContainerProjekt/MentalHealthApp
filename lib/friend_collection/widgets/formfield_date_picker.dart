import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:mental_health_app/friend_collection/database/database_operation.dart';

class FormfieldDatePicker extends StatefulWidget {
  final String textFieldTitle;
  final String textFieldValue;
  const FormfieldDatePicker(this.textFieldTitle, this.textFieldValue, {super.key});

  @override
  State<FormfieldDatePicker> createState() => _FormfieldDatePickerState();
}

class _FormfieldDatePickerState extends State<FormfieldDatePicker> {
  DateTime pickedDate = DateTime.now();
  void changeDate(newDate) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderDateTimePicker(
          name: widget.textFieldTitle,
          initialDate: DateTime.now(),
          initialValue: DateTime.tryParse(widget.textFieldValue),
          inputType: InputType.date,
          format: DateFormat("dd.MM.yyyy"),
          onChanged: (date) {
            changeDate(date);
            DatabaseOperation()
                .saveAndTryToUpdateString("birthday", date.toString() ?? "");
          },
          decoration: InputDecoration(
            constraints: BoxConstraints(maxWidth: 200.0),
          ),
          initialEntryMode: DatePickerEntryMode.calendar,
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

/**Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                    FormBuilderDateTimePicker(
                      name: widget.textFieldTitle,
                      initialDatePickerMode: DatePickerMode.year,                     
                      initialDate: pickedDate,          
                      firstDate: DateTime(1900),
                      //lastDate: DateTime(DateTime.now().year),
                      format: DateFormat("MM-dd-yyyy"),
                      inputType: InputType.date,
                      onChanged: (date) {
                        changeDate(date);
                        DatabaseOperation().saveAndTryToUpdateString("birthday", date.toString() ?? "");
                        Navigator.pop(context);
                      }
                    )
                  ],
                ),
              ),
            ),
          );
        },
        child: Text(
          pickedDate.toString().split(' ')[0]
        )
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          widget.textFieldTitle,
        )
      )
    ]); */