import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_button.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';

class TriangleInput4x4 extends ConsumerWidget {
  final Tuple2<Color, Color> colorTuple;
  final int level;

  const TriangleInput4x4({
    Key? key,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(magicTriangleProvider(level));
    final currentState = state.currentState;
    double remainHeight = getRemainHeight(context: context);
    double space = getPercentSize(remainHeight, 3.5);
    double horizontalSpace = getWidthPercentSize(context, 100) / 5;


    if (currentState == null) {
      return const SizedBox(); // or any loading/placeholder widget
    }
    Widget spaceWidget = SizedBox(
      width: getPercentSize(horizontalSpace, 10),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TriangleButton(
              is3x3: false,
              digit: currentState.listGrid[0],
              index: 0,
              colorTuple: colorTuple,
              level: level,
            ),
            spaceWidget,
            TriangleButton(
              is3x3: false,
              digit: currentState.listGrid[1],
              index: 1,
              colorTuple: colorTuple,
              level: level,
            ),
            spaceWidget,
            TriangleButton(
              digit: currentState.listGrid[2],
              index: 2,
              is3x3: false,
              colorTuple: colorTuple,
              level: level,
            ),
            spaceWidget,
            TriangleButton(
              digit: currentState.listGrid[3],
              index: 3,
              is3x3: false,
              colorTuple: colorTuple,
              level: level,
            ),
            spaceWidget,
            TriangleButton(
              digit: currentState.listGrid[4],
              index: 4,
              is3x3: false,
              colorTuple: colorTuple,
              level: level,
            ),
          ],
        ),
        SizedBox(height: space),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TriangleButton(
              is3x3: false,
              digit: currentState.listGrid[5],
              index: 5,
              colorTuple: colorTuple,
              level: level,
            ),
            spaceWidget,
            TriangleButton(
              digit: currentState.listGrid[6],
              index: 6,
              is3x3: false,
              colorTuple: colorTuple,
              level: level,
            ),
            spaceWidget,
            TriangleButton(
              digit: currentState.listGrid[7],
              index: 7,
              is3x3: false,
              colorTuple: colorTuple,
              level: level,
            ),
            spaceWidget,
            TriangleButton(
              digit: currentState.listGrid[8],
              index: 8,
              is3x3: false,
              colorTuple: colorTuple,
              level: level,
            ),
          ],
        )
      ],
    );
  }
}
