part of 'evaluation_widget_bloc.dart';

sealed class EvaluationWidgetEvent extends Equatable {
  const EvaluationWidgetEvent();
}

class EvaluationWidgetLoad extends EvaluationWidgetEvent {
  final Routine routine;

  const EvaluationWidgetLoad({required this.routine});

  @override
  List<Object?> get props => [];
}

class EvaluationWidgetSetValue extends EvaluationWidgetEvent {
  final double value;
  final int number;

  const EvaluationWidgetSetValue({required this.value, required this.number});

  @override
  List<Object?> get props => [value, number];
}

class EvaluationWidgetSetText extends EvaluationWidgetEvent {
  final String text;
  final int number;

  const EvaluationWidgetSetText({required this.text, required this.number});

  @override
  List<Object?> get props => [text, number];
}

class EvaluationWidgetSubmit extends EvaluationWidgetEvent {
  @override
  List<Object?> get props => [];
}
