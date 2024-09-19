import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mathsgames/src/ui/magicTriangle/magic_triangle_provider.dart';
import 'package:mathsgames/src/ui/magicTriangle/triangle_input_button.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class Triangle3x3 extends StatelessWidget {
  final double radius;
  final double padding;
  final double triangleHeight;
  final double triangleWidth;
  final Tuple2<Color, Color> colorTuple;

  Triangle3x3({
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
                )
              ],
            ),
          )),
        ],
      ),
    );

    // return SizedBox(
    //   width: triangleWidth,
    //   height: triangleHeight,
    //   child: Stack(
    //     children: <Widget>[
    //       Positioned(
    //         top: padding,
    //         left: triangleWidth / 2 - radius,
    //         child: TriangleInputButton(
    //           input: magicTriangleProvider.currentState.listTriangle[0],
    //           index: 0,
    //           colorTuple: colorTuple,
    //         ),
    //
    //       ), // first
    //       Positioned(
    //         top: triangleHeight / 2.3 - radius,
    //         left: (triangleWidth - ((radius + padding) * 2)) / 4 + padding,
    //         child: TriangleInputButton(
    //           input: magicTriangleProvider.currentState.listTriangle[1],
    //           index: 1,
    //           colorTuple: colorTuple,
    //         ),
    //
    //       ), // second one
    //       Positioned(
    //         top: triangleHeight / 2.3 - radius,
    //         right: (triangleWidth - ((radius + padding) * 2)) / 4 + padding,
    //         child: TriangleInputButton(
    //           input: magicTriangleProvider.currentState.listTriangle[2],
    //           index: 2,
    //           colorTuple: colorTuple,
    //         ),
    //       ), // third
    //       Positioned(
    //         bottom: padding,
    //         left: padding,
    //         child: Padding(
    //           padding:  EdgeInsets.only(left: (getHorizontalSpace(context)/2)),
    //           child: TriangleInputButton(
    //             input: magicTriangleProvider.currentState.listTriangle[3],
    //             index: 3,
    //             colorTuple: colorTuple,
    //           ),
    //         ),
    //       ), // fourth
    //       Positioned(
    //         bottom: padding,
    //         left: triangleWidth / 2 - radius,
    //         child: TriangleInputButton(
    //           input: magicTriangleProvider.currentState.listTriangle[4],
    //           index: 4,
    //           colorTuple: colorTuple,
    //         ),
    //       ), // fifth
    //       Positioned(
    //         bottom: padding,
    //         right: (padding),
    //         child: Padding(
    //           padding:  EdgeInsets.only(right: (getHorizontalSpace(context)/2)),
    //           child: TriangleInputButton(
    //             input: magicTriangleProvider.currentState.listTriangle[5],
    //             index: 5,
    //             colorTuple: colorTuple,
    //           ),
    //         ),
    //         ),
    //     ],
    //   ),
    // );
  }
}
