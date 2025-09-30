import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../utility/global_constants.dart';

class TriangleInput4x4 extends StatelessWidget {
  final Tuple2<Color, Color> colorTuple;

  const TriangleInput4x4({
    Key? key,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);

    double remainHeight = getRemainHeight(context: context);

    double space = getPercentSize(remainHeight, 3.5);
    double horizontalSpace = getWidthPercentSize(context, 100) / 5;
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
              digit: magicTriangleProvider.currentState.listGrid[0],
              index: 0,
              colorTuple: colorTuple,
            ),
            spaceWidget,
            TriangleButton(
              is3x3: false,
              digit: magicTriangleProvider.currentState.listGrid[1],
              index: 1,
              colorTuple: colorTuple,
            ),
            spaceWidget,
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[2],
              index: 2,
              is3x3: false,
              colorTuple: colorTuple,
            ),
            spaceWidget,
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[3],
              index: 3,
              is3x3: false,
              colorTuple: colorTuple,
            ),
            spaceWidget,
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[4],
              index: 4,
              is3x3: false,
              colorTuple: colorTuple,
            ),
          ],
        ),
        SizedBox(height: space),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TriangleButton(
              is3x3: false,
              digit: magicTriangleProvider.currentState.listGrid[5],
              index: 5,
              colorTuple: colorTuple,
            ),
            spaceWidget,
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[6],
              index: 6,
              is3x3: false,
              colorTuple: colorTuple,
            ),
            spaceWidget,
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[7],
              index: 7,
              is3x3: false,
              colorTuple: colorTuple,
            ),
            spaceWidget,
            TriangleButton(
              digit: magicTriangleProvider.currentState.listGrid[8],
              index: 8,
              is3x3: false,
              colorTuple: colorTuple,
            ),
          ],
        )
      ],
    );
  }
}
