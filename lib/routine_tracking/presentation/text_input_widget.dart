import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextInputState extends Equatable {
  final String text;
  final String error;

  const TextInputState({this.text = "", this.error = ""});

  @override
  List<Object?> get props => [text, error];
}

class TextInputWidget<B extends StateStreamable<S>, S> extends StatelessWidget {
  late TextStyle? textStyle;
  final int? maxLength;
  final int? minLength;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? label;

  final BlocWidgetSelector<S, TextInputState> selector;

  TextInputWidget(
      {super.key,
      required this.selector,
      this.textStyle,
      this.minLength,
      this.maxLength,
      this.inputFormatters,
      this.onChanged,
      this.label});

  @override
  Widget build(BuildContext context) {
    this.textStyle ??= Theme.of(context).textTheme.titleMedium;

    return BlocSelector<B, S, TextInputState>(
      selector: this.selector,
      builder: (BuildContext context, TextInputState state) {
        TextEditingController controller = TextEditingController();
        controller.text = state.text;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
        return TextField(
          textAlign: TextAlign.center,
          style: this.textStyle,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: this.label,
              errorText: state.error),
          maxLength: this.minLength,
          maxLines: this.maxLength,
          inputFormatters: this.inputFormatters,
          controller: controller,
          onChanged: this.onChanged,
        );
      },
    );
  }
}
