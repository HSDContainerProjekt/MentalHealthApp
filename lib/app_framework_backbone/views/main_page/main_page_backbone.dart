import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/bloc/main_page_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/main_page_animal.dart';

import '../../../routine_tracking/data/data_model/routine.dart';
import '../../../routine_tracking/domain/routine_repository.dart';
import '../../../routine_tracking/presentation/evaluation_widget.dart';
import '../../../software_backbone/routing/routing_constants.dart';
import '../../../software_backbone/themes/theme_constraints.dart';
import '../custom_image/custom_image_widget.dart';

final double areaWidth = 1500;
final double areaHeight = 1500;

class HomePage extends StatelessWidget {
  final List<_Line> routineLines = [
    _Line(x1: 10, y1: -120, x2: -20, y2: -180, x3: -60, y3: -180),
    _Line(x1: 90, y1: -0, x2: 120, y2: -20, x3: 130, y3: -60),
    _Line(x1: -85, y1: 30, x2: -110, y2: 40, x3: -130, y3: 50),
    _Line(x1: 80, y1: 70, x2: 130, y2: 100, x3: 160, y3: 130),
  ];

  final List<_Offset> imageOffset = [
    _Offset(y: -200, x: -110),
    _Offset(y: -110, x: 170),
    _Offset(y: 50, x: -180),
    _Offset(y: 180, x: 200),
  ];

  final List<_Line> titleLines = [
    _Line(x1: -150, y1: -157, x2: -169, y2: -142, x3: -168, y3: -116),
    _Line(x1: 203, y1: -56, x2: 237, y2: -27, x3: 236, y3: 14),
    _Line(x1: -230, y1: 75, x2: -268, y2: 112, x3: -273, y3: 156),
    _Line(x1: 201, y1: 235, x2: 156, y2: 278, x3: 163, y3: 337),
  ];

  final List<_Offset> titleOffset = [
    _Offset(x: -164.0, y: -99.0),
    _Offset(x: 241, y: 34),
    _Offset(x: -275, y: 175),
    _Offset(x: 163, y: 357),
  ];

  final List<_Line> evaluationLines = [
    _Line(x1: -108, y1: -246, x2: -86, y2: -288, x3: -18, y3: -281),
    _Line(x1: 220, y1: -76, x2: 263, y2: -42, x3: 317, y3: -33),
    _Line(x1: -228, y1: 16, x2: -251, y2: 2, x3: -285, y3: 0),
    _Line(x1: 248, y1: 209, x2: 300, y2: 257, x3: 378, y3: 270),
  ];

  final List<_Offset> evaluationOffset = [
    _Offset(x: 90, y: -240),
    _Offset(x: 430, y: -10),
    _Offset(x: -394, y: 40),
    _Offset(x: 493, y: 313),
  ];

  final List<_Line> nextTimeLines = [
    _Line(x1: -166, y1: -209, x2: -210, y2: -281, x3: -210, y3: -281),
    _Line(x1: 223, y1: -138, x2: 270, y2: -174, x3: 276, y3: -235),
    _Line(x1: -236, y1: 49, x2: -290, y2: 96, x3: -351, y3: 119),
    _Line(x1: 251, y1: 173, x2: 292, y2: 151, x3: 313, y3: 117),
  ];

  final List<_Offset> nextTimeOffset = [
    _Offset(x: -208, y: -308),
    _Offset(x: 282, y: -261),
    _Offset(x: -399, y: 135),
    _Offset(x: 318, y: 95),
  ];

  final List<_Line> descriptionLines = [
    _Line(x1: -134, y1: -252, x2: -113, y2: -300, x3: -113, y3: -354),
    _Line(x1: 194, y1: -159, x2: 211, y2: -263, x3: 258, y3: -323),
    _Line(x1: -170, y1: 104, x2: -140, y2: 250, x3: -439, y3: 220),
    _Line(x1: 229, y1: 238, x2: 213, y2: 466, x3: 260, y3: 502),
  ];

  final List<_Offset> descriptionOffset = [
    _Offset(x: -140, y: -360),
    _Offset(x: 323, y: -328),
    _Offset(x: -553, y: 257),
    _Offset(x: 370, y: 529),
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: mainPageThemeData,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: LayoutBuilder(
          builder: (context, constraints) {
            final xTranslate = (areaWidth - constraints.maxWidth) / 2;
            final yTranslate = (areaHeight - constraints.maxHeight) / 2;

            var transformationController = TransformationController();
            transformationController.value.setEntry(0, 0, 1);
            transformationController.value.setEntry(1, 1, 1);
            transformationController.value.setEntry(2, 2, 1);
            transformationController.value.setEntry(0, 3, -xTranslate);
            transformationController.value.setEntry(1, 3, -yTranslate);

            return BlocProvider(
              create: (_) => MainPageBloc(
                routineRepository: context.read<RoutineRepository>(),
              )..add(MainPageEventRefresh()),
              child: InteractiveViewer(
                onInteractionUpdate: (details) {},
                transformationController: transformationController,
                clipBehavior: Clip.none,
                constrained: false,
                minScale: 0.05,
                maxScale: 3,
                child: Center(
                  child: GestureDetector(
                    onTapDown: (details) {
                      double x = details.localPosition.dx - areaWidth / 2;
                      double y = details.localPosition.dy - areaWidth / 2;

                      print(
                          "###LokalePosition x: ${x.round()}, y: ${-y.round()}");
                      print(
                          "###LokalePosition x1: ${x.round()}, y1: ${-y.round()}");
                      print(
                          "###LokalePosition x2: ${x.round()}, y2: ${-y.round()}");
                      print(
                          "###LokalePosition x3: ${x.round()}, y3: ${-y.round()}");
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          scale: 3,
                          repeat: ImageRepeat.repeat,
                          image: AssetImage(
                              "lib/assets/images/background_paper/paper_basic/dotted_paper_white-turquois.jpg"),
                        ),
                      ),
                      height: areaHeight,
                      width: areaWidth,
                      child: BlocSelector<MainPageBloc, MainPageState,
                          (List<RoutineWithExtraInfoTimeLeft>, int?)>(
                        selector: (state) {
                          return (state.routines, state.selected);
                        },
                        builder: (context, state) {
                          List<_Line> blackLines = [
                            //Überschrift
                            _Line(
                                x1: -10,
                                y1: 90,
                                x2: -40,
                                y2: 120,
                                x3: -40,
                                y3: constraints.maxHeight / 2 - 110),
                          ];
                          List<_Line> selectedLines = [];
                          for (int i = 0; i < state.$1.length; i++) {
                            if (state.$2 == i) {
                              selectedLines.add(routineLines[i]);
                              selectedLines.add(titleLines[i]);
                              selectedLines.add(evaluationLines[i]);
                              selectedLines.add(nextTimeLines[i]);
                              selectedLines.add(descriptionLines[i]);
                            } else {
                              blackLines.add(routineLines[i]);
                              blackLines.add(titleLines[i]);
                              blackLines.add(evaluationLines[i]);
                              blackLines.add(nextTimeLines[i]);
                              blackLines.add(descriptionLines[i]);
                            }
                          }
                          return Stack(
                            children: [
                              //Black Lines
                              CustomPaint(
                                size: Size(areaWidth, areaHeight),
                                painter: _LinePainter(
                                  strokeWidth: 2,
                                  color: Colors.black,
                                  lines: blackLines,
                                ),
                              ),
                              //Selected Lines
                              CustomPaint(
                                size: Size(areaWidth, areaHeight),
                                painter: _LinePainter(
                                  strokeWidth: 4,
                                  color: Theme.of(context).colorScheme.primary,
                                  lines: selectedLines,
                                ),
                              ),
                              //Animal
                              Center(
                                child: Transform.translate(
                                  offset: const Offset(0.0, 20),
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    radius: Radius.circular(40),
                                    dashPattern: [7, 7],
                                    strokeWidth: 3,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: BlocSelector<MainPageBloc,
                                          MainPageState, MainPageAnimalState?>(
                                        selector: (state) {
                                          return state.mainPageAnimalState;
                                        },
                                        builder: (context, state) {
                                          if (state == null) {
                                            return CircularProgressIndicator();
                                          }
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              MainPageAnimal(
                                                  mainPageAnimalState: state),
                                              Text(
                                                state.name(context),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Center(
                                child: Transform.translate(
                                  offset: Offset(
                                      -30.0, -constraints.maxHeight / 2 + 50),
                                  child: DottedBorder(
                                    borderType: BorderType.RRect,
                                    padding: EdgeInsets.all(10),
                                    radius: Radius.circular(30),
                                    dashPattern: [10, 10],
                                    strokeWidth: 3,
                                    child: Text(
                                        AppLocalizations.of(context)!
                                            .homepageTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                  ),
                                ),
                              ),
                              if (state.$1.length == 0)
                                _LinkToRoutine(
                                  offset: _Offset(
                                      x: 10,
                                      y: -constraints.maxHeight / 2 + 50),
                                )
                              else
                                Stack(
                                  children: [
                                    //Image
                                    Stack(
                                      children: state.$1
                                          .asMap()
                                          .map((int i,
                                              RoutineWithExtraInfoTimeLeft x) {
                                            return MapEntry(
                                              i,
                                              GestureDetector(
                                                onTap: () {
                                                  context
                                                      .read<MainPageBloc>()
                                                      .add(MainPageEventSelect(
                                                          selected: i));
                                                },
                                                child: _ImageWidget(
                                                  selected: i == state.$2,
                                                  imageID: x.routine.imageID,
                                                  offset: imageOffset[i],
                                                ),
                                              ),
                                            );
                                          })
                                          .values
                                          .toList(),
                                    ),
                                    //Title
                                    Stack(
                                      children: state.$1
                                          .asMap()
                                          .map(
                                            (int i,
                                                RoutineWithExtraInfoTimeLeft
                                                    x) {
                                              return MapEntry(
                                                i,
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<MainPageBloc>()
                                                        .add(
                                                            MainPageEventSelect(
                                                                selected: i));
                                                  },
                                                  child: _TextOffsetWidget(
                                                    text: x.routine.title,
                                                    offset: titleOffset[i],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                          .values
                                          .toList(),
                                    ),
                                    //Evaluation
                                    Stack(
                                      children: state.$1
                                          .asMap()
                                          .map(
                                            (int i,
                                                RoutineWithExtraInfoTimeLeft
                                                    x) {
                                              return MapEntry(
                                                i,
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<MainPageBloc>()
                                                        .add(
                                                            MainPageEventSelect(
                                                                selected: i));
                                                  },
                                                  child: _EvaluationWidget(
                                                    selected: i == state.$2,
                                                    routine: x.routine,
                                                    offset: evaluationOffset[i],
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                          .values
                                          .toList(),
                                    ),
                                    //Evaluation
                                    Stack(
                                      children: state.$1
                                          .asMap()
                                          .map(
                                            (int i,
                                                RoutineWithExtraInfoTimeLeft
                                                    x) {
                                              TextStyle? style = Theme.of(
                                                      context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      fontWeight: x.timeLeft
                                                                  .inMinutes <
                                                              10
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      fontSize: max(
                                                          2000.0 /
                                                              (40 +
                                                                  x.timeLeft
                                                                      .inMinutes),
                                                          18));

                                              return MapEntry(
                                                i,
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<MainPageBloc>()
                                                        .add(
                                                            MainPageEventSelect(
                                                                selected: i));
                                                  },
                                                  child: _TextOffsetWidget(
                                                    offset: nextTimeOffset[i],
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .nextTime(
                                                            x.timeLeft.inDays,
                                                            x.timeLeft.inHours %
                                                                24,
                                                            x.timeLeft
                                                                    .inMinutes %
                                                                60),
                                                    style: style,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                          .values
                                          .toList(),
                                    ),
                                    Stack(
                                      children: state.$1
                                          .asMap()
                                          .map(
                                            (int i,
                                                RoutineWithExtraInfoTimeLeft
                                                    x) {
                                              return MapEntry(
                                                i,
                                                GestureDetector(
                                                  onTap: () {
                                                    context
                                                        .read<MainPageBloc>()
                                                        .add(
                                                            MainPageEventSelect(
                                                                selected: i));
                                                  },
                                                  child: _DescriptionWidget(
                                                    routine: x.routine,
                                                    offset:
                                                        descriptionOffset[i],
                                                    selected: i == state.$2,
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                          .values
                                          .toList(),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Offset {
  final double x;
  final double y;

  _Offset({
    required this.x,
    required this.y,
  });
}

class _ImageWidget extends StatelessWidget {
  final _Offset offset;
  final int imageID;
  final bool selected;

  const _ImageWidget(
      {super.key,
      required this.offset,
      required this.imageID,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(offset.x, -offset.y),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color:
              selected ? Theme.of(context).colorScheme.primary : Colors.black,
          radius: Radius.circular(10),
          borderPadding: EdgeInsets.all(selected ? -1 : 1),
          dashPattern: selected ? [10, 5] : [5, 5],
          strokeWidth: selected ? 5 : 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 75,
              width: 75,
              child: CustomImageWidget(imageID: imageID),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextOffsetWidget extends StatelessWidget {
  final _Offset offset;
  final String text;
  final TextStyle? style;

  const _TextOffsetWidget(
      {super.key,
      required this.offset,
      required this.text,
      required this.style});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(offset.x, -offset.y),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

class _Line {
  final double x1;
  final double y1;
  final double x2;
  final double y2;
  final double x3;
  final double y3;

  _Line(
      {required this.x1,
      required this.y1,
      required this.x3,
      required this.y3,
      required this.x2,
      required this.y2});
}

class _LinePainter extends CustomPainter {
  final List<_Line> lines;
  final Color color;
  final double strokeWidth;

  _LinePainter(
      {super.repaint,
      required this.lines,
      required this.color,
      required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    double xOffset = size.width / 2;
    double yOffset = size.height / 2;

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    for (_Line x in lines) {
      Path path = Path();
      path.moveTo(xOffset + x.x1, yOffset - x.y1);
      path.cubicTo(xOffset + x.x1, yOffset - x.y1, xOffset + x.x2,
          yOffset - x.y2, xOffset + x.x3, yOffset - x.y3);
      canvas.drawPath(path, paint);
    }
  }

  bool shouldRepaint(_LinePainter oldDelegate) => false;
}

class _EvaluationWidget extends StatelessWidget {
  final Routine routine;
  final _Offset offset;
  final bool selected;

  const _EvaluationWidget(
      {super.key,
      required this.offset,
      required this.routine,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset.x, -offset.y + areaHeight / 2),
      child: Align(
        alignment: Alignment.topCenter,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          color:
              selected ? Theme.of(context).colorScheme.primary : Colors.black,
          borderPadding: EdgeInsets.all(selected ? -1 : 1),
          dashPattern: selected ? [10, 5] : [5, 5],
          strokeWidth: selected ? 5 : 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 200,
                maxWidth: 200,
                minHeight: 100,
                maxHeight: selected ? 300 : 100,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                        style: Theme.of(context).textTheme.labelLarge,
                        AppLocalizations.of(context)!.evaluation),
                    EvaluationWidget(
                      routine: routine,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  final Routine routine;
  final _Offset offset;
  final bool selected;

  const _DescriptionWidget(
      {super.key,
      required this.offset,
      required this.routine,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
        offset: Offset(offset.x, -offset.y + areaHeight / 2),
        child: Align(
          alignment: Alignment.topCenter,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(10),
            color:
                selected ? Theme.of(context).colorScheme.primary : Colors.black,
            borderPadding: EdgeInsets.all(selected ? -1 : 1),
            dashPattern: selected ? [10, 5] : [5, 5],
            strokeWidth: selected ? 5 : 2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 200,
                  maxWidth: 200,
                  minHeight: 50,
                  maxHeight: 200,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                          style: selected
                              ? Theme.of(context).textTheme.labelLarge
                              : Theme.of(context).textTheme.labelMedium,
                          AppLocalizations.of(context)!.description),
                      selected
                          ? Text(
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              routine.description.trim().isEmpty
                                  ? routine.shortDescription
                                  : routine.description)
                          : Text(
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                              routine.shortDescription)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}

class _LinkToRoutine extends StatelessWidget {
  final _Offset offset;

  const _LinkToRoutine({super.key, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(offset.x, -offset.y),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, routineTracking);
          },
          child: Text(
            textAlign: TextAlign.center,
            AppLocalizations.of(context)!.noRoutine,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
