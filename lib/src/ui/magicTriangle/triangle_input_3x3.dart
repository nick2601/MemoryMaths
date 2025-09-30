import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_button.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:tuple/tuple.dart';

import '../../utility/Constants.dart';

class TriangleInput3x3 extends ConsumerWidget {
  final Tuple2<Color, Color> colorTuple;
  final int level;

  const TriangleInput3x3({
    Key? key,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(magicTriangleProvider(level));
    final currentState = state.currentState;

    if (currentState == null) {
      return const SizedBox(); // or any loading/placeholder widget
    }

    double remainHeight = getRemainHeight(context: context);
    double space = getPercentSize(remainHeight, 3.5);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            TriangleInputButton(
              input: currentState.listTriangle[0],
              index: 0,
              colorTuple: colorTuple,
              cellHeight: 40,
              level: level,
            ),
            SizedBox(height: space),
            TriangleButton(
              is3x3: true,
              digit: currentState.listGrid[1],
              index: 1,
              colorTuple: colorTuple,
              level: level,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            TriangleButton(
              is3x3: true,
              digit: currentState.listGrid[2],
              index: 2,
              colorTuple: colorTuple,
              level: level,
            ),
            SizedBox(height: space),
            TriangleButton(
              is3x3: true,
              digit: currentState.listGrid[3],
              index: 3,
              colorTuple: colorTuple,
              level: level,
            ),
          ],
        ),
        Column(
          children: <Widget>[
            TriangleButton(
              is3x3: true,
              digit: currentState.listGrid[4],
              index: 4,
              colorTuple: colorTuple,
              level: level,
            ),
            SizedBox(height: space),
            TriangleButton(
              is3x3: true,
              digit: currentState.listGrid[5],
              index: 5,
              colorTuple: colorTuple,
              level: level,
            ),
          ],
        ),
      ],
    );
  }
}
