import 'dart:math';

import 'package:arrow_path/arrow_path.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/bloc/main_page_bloc.dart';
import 'package:mental_health_app/app_framework_backbone/views/main_page/main_page_animal.dart';

import '../../../routine_tracking/data/data_model/routine.dart';
import '../../../routine_tracking/domain/routine_repository.dart';
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
    _Offset(x: 427, y: 8),
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
                          List<RoutineWithExtraInfoTimeLeft>>(
                        selector: (state) {
                          return state.routines;
                        },
                        builder: (context, state) {
                          List<_Line> lines = [
                            //Überschrift
                            _Line(
                                x1: -10,
                                y1: 90,
                                x2: -40,
                                y2: 120,
                                x3: -40,
                                y3: constraints.maxHeight / 2 - 110),
                          ];
                          for (int i = 0; i < state.length; i++) {
                            lines.add(routineLines[i]);
                            lines.add(titleLines[i]);
                            lines.add(evaluationLines[i]);
                            lines.add(nextTimeLines[i]);
                          }
                          return Stack(
                            children: [
                              CustomPaint(
                                size: Size(areaWidth, areaHeight),
                                painter: _LinePainter(
                                  lines: lines,
                                ),
                              ),
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
                                                state.animalToString(context),
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
                              if (state.length == 0)
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
                                      children: state
                                          .asMap()
                                          .map((int i,
                                              RoutineWithExtraInfoTimeLeft x) {
                                            return MapEntry(
                                              i,
                                              _ImageWidget(
                                                imageID: x.routine.imageID,
                                                offset: imageOffset[i],
                                              ),
                                            );
                                          })
                                          .values
                                          .toList(),
                                    ),
                                    //Title
                                    Stack(
                                      children: state
                                          .asMap()
                                          .map((int i,
                                              RoutineWithExtraInfoTimeLeft x) {
                                            return MapEntry(
                                              i,
                                              _TextOffsetWidget(
                                                text: x.routine.title,
                                                offset: titleOffset[i],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            );
                                          })
                                          .values
                                          .toList(),
                                    ),
                                    //Evaluation
                                    Stack(
                                      children: state
                                          .asMap()
                                          .map((int i,
                                              RoutineWithExtraInfoTimeLeft x) {
                                            return MapEntry(
                                              i,
                                              _EvaluationWidget(
                                                offset: evaluationOffset[i],
                                              ),
                                            );
                                          })
                                          .values
                                          .toList(),
                                    ),
                                    //Evaluation
                                    Stack(
                                      children: state
                                          .asMap()
                                          .map((int i,
                                              RoutineWithExtraInfoTimeLeft x) {
                                            TextStyle? style = Theme.of(context)
                                                .textTheme
                                                .labelLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        x.timeLeft.inMinutes <
                                                                10
                                                            ? FontWeight.bold
                                                            : FontWeight.normal,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontSize: max(
                                                        2000.0 /
                                                            (40 +
                                                                x.timeLeft
                                                                    .inMinutes),
                                                        18));

                                            return MapEntry(
                                              i,
                                              _TextOffsetWidget(
                                                offset: nextTimeOffset[i],
                                                text: x.intervalAsString(),
                                                style: style,
                                              ),
                                            );
                                          })
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

  const _ImageWidget({super.key, required this.offset, required this.imageID});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.translate(
        offset: Offset(offset.x, -offset.y),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          borderPadding: EdgeInsets.all(2),
          dashPattern: [5, 5],
          strokeWidth: 4,
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

  _LinePainter({super.repaint, required this.lines});

  @override
  void paint(Canvas canvas, Size size) {
    double xOffset = size.width / 2;
    double yOffset = size.height / 2;

    final Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

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
  final _Offset offset;

  const _EvaluationWidget({super.key, required this.offset});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(offset.x, -offset.y + areaHeight / 2),
      child: Align(
        alignment: Alignment.topCenter,
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(10),
          borderPadding: EdgeInsets.all(2),
          dashPattern: [5, 5],
          strokeWidth: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: Colors.yellow,
              height: 75,
              width: 200,
            ),
          ),
        ),
      ),
    );
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
            "Du hast noch keine Routinen.\nKlicke Hier um welche zu erstellen.",
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
