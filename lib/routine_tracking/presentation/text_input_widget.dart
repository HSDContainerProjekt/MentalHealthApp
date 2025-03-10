import 'package:dotted_border/dotted_border.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextInputState extends Equatable {
  final String text;
  final String? error;

  const TextInputState({this.text = "", this.error});

  @override
  List<Object?> get props => [text, error];
}

class TextInputWidget<B extends StateStreamable<S>, S> extends StatelessWidget {
  late TextStyle? inputTextStyle;
  late TextStyle? labelTextStyle;
  late TextStyle? errorTextStyle;

  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final String? label;

  final BlocWidgetSelector<S, TextInputState> selector;

  TextInputWidget(
      {super.key,
      required this.selector,
      this.minLines,
      this.maxLines,
      this.inputTextStyle,
      this.labelTextStyle,
      this.errorTextStyle,
      this.maxLength,
      this.inputFormatters,
      this.onChanged,
      this.label});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    this.inputTextStyle ??= Theme.of(context).textTheme.headlineMedium;
    this.labelTextStyle ??= Theme.of(context).textTheme.labelMedium;
    this.errorTextStyle ??= Theme.of(context)
        .textTheme
        .labelSmall
        ?.copyWith(color: colorScheme.error);

    return BlocSelector<B, S, TextInputState>(
      selector: this.selector,
      builder: (BuildContext context, TextInputState state) {
        TextEditingController controller = TextEditingController();
        controller.text = state.text;
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length),
        );
        return DottedBorder(
          strokeWidth: 2,
          radius: Radius.circular(5),
          dashPattern: [5],
          child: TextField(
            cursorColor: colorScheme.primary,
            cursorErrorColor: colorScheme.error,
            decoration: InputDecoration(
              focusedBorder: InputBorder.none,
              counterText: "",
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorScheme.error, width: 1.0),
              ),
              errorText: state.error,
              errorStyle: this.errorTextStyle,
              labelText: this.label,
              labelStyle: this.labelTextStyle,
            ),
            textAlign: TextAlign.center,
            style: this.inputTextStyle,
            maxLength: this.maxLength,
            minLines: this.minLines,
            maxLines: this.maxLines,
            inputFormatters: this.inputFormatters,
            controller: controller,
            onChanged: this.onChanged,
          ),
        );
      },
    );
  }
}
