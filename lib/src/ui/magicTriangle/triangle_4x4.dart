import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:mathsgames/src/utility/Constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Triangle4x4 extends StatelessWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  final double triangleWidth;
  final Tuple2<Color, Color> colorTuple;

  Triangle4x4({
    required this.radius,
    required this.padding,
    required this.triangleHeight,
    required this.triangleWidth,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    final magicTriangleProvider = Provider.of<MagicTriangleProvider>(context);

    double remainHeight = triangleHeight;
    double height = remainHeight / 14;

    remainHeight = remainHeight - (height * 2.5);

    double cellHeight = remainHeight / 6;

    // return SizedBox(
    //   width: triangleWidth,
    //   height: triangleHeight,
    //   child: Stack(
    //     children: <Widget>[
    //       Positioned(
    //         top: padding,
    //         left: triangleWidth / 2 - radius,
    //         child: TriangleInputButton(
    //           cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[0],
    //           index: 0,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // first
    //       Positioned(
    //         top: (triangleHeight - ((radius + padding) * 2)) / 3 + padding,
    //         left: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
    //         child: TriangleInputButton(
    //           cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[1],
    //           index: 1,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // second one
    //       Positioned(
    //         top: (triangleHeight - ((radius + padding) * 2)) / 3 + padding,
    //         right: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
    //         child: TriangleInputButton( cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[2],
    //           index: 2,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // third
    //       Positioned(
    //         bottom: (triangleHeight - ((radius + padding) * 2)) / 3.4 + padding,
    //         left: (triangleWidth - ((radius + padding) * 2)) / 6 + padding,
    //         child: TriangleInputButton( cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[3],
    //           index: 3,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // fourth one
    //       Positioned(
    //         bottom: (triangleHeight - ((radius + padding) * 2)) / 3.4 + padding,
    //         right: (triangleWidth - ((radius + padding) * 2)) / 6 + padding,
    //         child: TriangleInputButton( cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[4],
    //           index: 4,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // fifth
    //       Positioned(
    //         bottom: padding,
    //         left: padding,
    //         child: TriangleInputButton( cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[5],
    //           index: 5,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // fourth
    //       Positioned(
    //         bottom: padding,
    //         left: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
    //         child: TriangleInputButton( cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[6],
    //           index: 6,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // sixth
    //       Positioned(
    //         bottom: padding,
    //         right: (triangleWidth - ((radius + padding) * 2)) / 3 + padding,
    //         child: TriangleInputButton( cellHeight:cellHeight,
    //           input: magicTriangleProvider.currentState.listTriangle[7],
    //           index: 7,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), // seventh
    //       Positioned(
    //         bottom: padding,
    //         right: padding,
    //         child: TriangleInputButton( cellHeight:cellHeight,
    //
    //           input: magicTriangleProvider.currentState.listTriangle[8],
    //           index: 8,
    //           colorTuple: colorTuple,
    //         ),
    //         // height: (radius * 2),
    //         // width: (radius * 2),
    //       ), //ninth
    //     ],
    //   ),
    // );

    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: TriangleInputButton(
                  cellHeight: cellHeight,
                  input: magicTriangleProvider.currentState.listTriangle[0],
                  index: 0,
                  colorTuple: colorTuple,
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 7)),
            child: Row(
              children: [
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[1],
                      index: 1,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[2],
                      index: 2,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                )
              ],
            ),
          )),
          Expanded(
              child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: getWidthPercentSize(context, 10)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[3],
                      index: 3,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[4],
                      index: 4,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
              ],
            ),
          )),
          Expanded(
              child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[5],
                      index: 5,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[6],
                      index: 6,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[7],
                      index: 7,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    child: Center(
                        child: TriangleInputButton(
                      input: magicTriangleProvider.currentState.listTriangle[8],
                      index: 8,
                      colorTuple: colorTuple,
                      cellHeight: cellHeight,
                    )),
                  ),
                  flex: 1,
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
