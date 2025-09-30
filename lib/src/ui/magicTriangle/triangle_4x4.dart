import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:tuple/tuple.dart';

class Triangle4x4 extends ConsumerWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  final double triangleWidth;
  final Tuple2<Color, Color> colorTuple;
  final int level;

  const Triangle4x4({
    Key? key,
    required this.radius,
    required this.padding,
    required this.triangleHeight,
    required this.triangleWidth,
    required this.colorTuple,
    required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(magicTriangleProvider(level));
    final listTriangle = state.currentState?.listTriangle ?? [];

    if (listTriangle.length < 9) {
      return const SizedBox.shrink();
    }

    double remainHeight = triangleHeight;
    double height = remainHeight / 14;
    remainHeight = remainHeight - (height * 2.5);
    double cellHeight = remainHeight / 6;

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: TriangleInputButton(
              cellHeight: cellHeight,
              input: listTriangle[0],
              index: 0,
              colorTuple: colorTuple,
              level: level,
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: getWidthPercentSize(context, 7),
            ),
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: Center(
                    child: TriangleInputButton(
                      input: listTriangle[1],
                      index: 1,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                      level: level,
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Center(
                    child: TriangleInputButton(
                      input: listTriangle[2],
                      index: 2,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                      level: level,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: getWidthPercentSize(context, 10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: TriangleInputButton(
                      input: listTriangle[3],
                      index: 3,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                      level: level,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  child: Center(
                    child: TriangleInputButton(
                      input: listTriangle[4],
                      index: 4,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                      level: level,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: TriangleInputButton(
                    input: listTriangle[5],
                    index: 5,
                    colorTuple: colorTuple,
                    cellHeight: cellHeight,
                    level: level,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: TriangleInputButton(
                    input: listTriangle[6],
                    index: 6,
                    colorTuple: colorTuple,
                    cellHeight: cellHeight,
                    level: level,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: TriangleInputButton(
                    input: listTriangle[7],
                    index: 7,
                    colorTuple: colorTuple,
                    cellHeight: cellHeight,
                    level: level,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: TriangleInputButton(
                    input: listTriangle[8],
                    index: 8,
                    colorTuple: colorTuple,
                    cellHeight: cellHeight,
                    level: level,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
