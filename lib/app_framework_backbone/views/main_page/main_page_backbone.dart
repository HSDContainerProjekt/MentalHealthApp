import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final xTranslate = (1000 - constraints.maxWidth) / 2;
          final yTranslate = (1300 - constraints.maxHeight) / 2;

          var transformationController = TransformationController();
          transformationController.value.setEntry(0, 0, 1);
          transformationController.value.setEntry(1, 1, 1);
          transformationController.value.setEntry(2, 2, 1);
          transformationController.value.setEntry(0, 3, -xTranslate);
          transformationController.value.setEntry(1, 3, -yTranslate);

          return InteractiveViewer(
              transformationController: transformationController,
              clipBehavior: Clip.none,
              constrained: false,
              minScale: 0.05,
              maxScale: 3,
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      scale: 3,
                      repeat: ImageRepeat.repeat,
                      image: AssetImage(
                          "lib/assets/images/background_paper/paper_basic/dotted_paper_white-pink.jpg"),
                    ),
                  ),
                  height: 1300,
                  width: 1000,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          "lib/assets/images/maxie_bodyshot.png",
                          height: 200.0,
                          width: 200.0,
                        ),
                      ),
                      Center(
                        child: Transform.translate(
                          offset: const Offset(150.0, 0.0),
                          child: Container(
                            padding: const EdgeInsets.all(8.0),
                            color: const Color(0xFF7F7F7F),
                            child: const Text('Quarter'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ));
/*
          FreeScrollView(
            xOffset: (1000 - constraints.maxWidth) / 2,
            yOffset: (1000 - constraints.maxHeight) / 2,
            child: Container(
              height: 1000,
              width: 1000,
              child: Stack(
                children: [
                  Center(
                    child: Image.asset(
                      "lib/assets/images/maxie_bodyshot.png",
                      height: 125.0,
                      width: 125.0,
                    ),
                  )
                ],
              ),
            ),
          );
          */
        },
      ),
    );
  }
}

class FreeScrollView extends StatefulWidget {
  final Widget child;
  final ScrollPhysics physics;

  final double xOffset;
  final double yOffset;

  const FreeScrollView(
      {Key? key,
      this.physics = const ClampingScrollPhysics(),
      required this.child,
      required this.xOffset,
      required this.yOffset})
      : super(key: key);

  @override
  State<FreeScrollView> createState() =>
      _FreeScrollViewState(xOffset: xOffset, yOffset: yOffset);
}

class _FreeScrollViewState extends State<FreeScrollView> {
  final double xOffset;
  final double yOffset;

  _FreeScrollViewState({required this.xOffset, required this.yOffset})
      : _verticalController = ScrollController(initialScrollOffset: yOffset),
        _horizontalController = ScrollController(initialScrollOffset: xOffset);

  final ScrollController _verticalController;
  final ScrollController _horizontalController;
  final Map<Type, GestureRecognizerFactory> _gestureRecognizers =
      <Type, GestureRecognizerFactory>{};

  @override
  void initState() {
    super.initState();
    _gestureRecognizers[PanGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<PanGestureRecognizer>(
            () => PanGestureRecognizer(),
            (instance) => instance
              ..onDown = _handleDragDown
              ..onStart = _handleDragStart
              ..onUpdate = _handleDragUpdate
              ..onEnd = _handleDragEnd
              ..onCancel = _handleDragCancel
              ..minFlingDistance = widget.physics.minFlingDistance
              ..minFlingVelocity = widget.physics.minFlingVelocity
              ..maxFlingVelocity = widget.physics.maxFlingVelocity
              ..velocityTrackerBuilder = ScrollConfiguration.of(context)
                  .velocityTrackerBuilder(context)
              ..dragStartBehavior = DragStartBehavior.start);
  }

  @override
  Widget build(BuildContext context) => Stack(children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _horizontalController,
            physics: widget.physics,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                // ignore: avoid_redundant_argument_values
                controller: _verticalController,
                physics: widget.physics,
                child: widget.child)),
        Positioned.fill(
            child: RawGestureDetector(
          gestures: _gestureRecognizers,
          behavior: HitTestBehavior.opaque,
          excludeFromSemantics: true,
        )),
      ]);

  Drag? _horizontalDrag;
  Drag? _verticalDrag;
  ScrollHoldController? _horizontalHold;
  ScrollHoldController? _verticalHold;

  void _handleDragDown(DragDownDetails details) {
    _horizontalHold =
        _horizontalController.position.hold(() => _horizontalHold = null);
    _verticalHold =
        _verticalController.position.hold(() => _verticalHold = null);
  }

  void _handleDragStart(DragStartDetails details) {
    _horizontalDrag = _horizontalController.position
        .drag(details, () => _horizontalDrag = null);
    _verticalDrag =
        _verticalController.position.drag(details, () => _verticalDrag = null);
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    _horizontalDrag?.update(DragUpdateDetails(
        sourceTimeStamp: details.sourceTimeStamp,
        delta: Offset(details.delta.dx, 0),
        primaryDelta: details.delta.dx,
        globalPosition: details.globalPosition));
    _verticalDrag?.update(DragUpdateDetails(
        sourceTimeStamp: details.sourceTimeStamp,
        delta: Offset(0, details.delta.dy),
        primaryDelta: details.delta.dy,
        globalPosition: details.globalPosition));
  }

  void _handleDragEnd(DragEndDetails details) {
    _horizontalDrag?.end(DragEndDetails(
        velocity: details.velocity,
        primaryVelocity: details.velocity.pixelsPerSecond.dx));
    _verticalDrag?.end(DragEndDetails(
        velocity: details.velocity,
        primaryVelocity: details.velocity.pixelsPerSecond.dy));
  }

  void _handleDragCancel() {
    _horizontalHold?.cancel();
    _horizontalDrag?.cancel();
    _verticalHold?.cancel();
    _verticalDrag?.cancel();
  }
}
