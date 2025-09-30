import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/number_pyramid.dart';
import 'package:mathsgames/src/ui/numberPyramid/number_pyramid_provider.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import 'package:figma_squircle/figma_squircle.dart';

class PyramidNumberButton extends StatelessWidget {
  final NumPyramidCellModel numPyramidCellModel;
  final bool isLeftRadius;
  final bool isRightRadius;
  final double height;
  final double buttonHeight;
  final Tuple2<Color, Color> colorTuple;

  PyramidNumberButton({
    required this.numPyramidCellModel,
    this.isLeftRadius = false,
    this.isRightRadius = false,
    required this.height,
    required this.buttonHeight,
    required this.colorTuple,
  });

  @override
  Widget build(BuildContext context) {
    final numberProvider = Provider.of<NumberPyramidProvider>(context);

    double screenWidth = getWidthPercentSize(context, 100);
    double screenHeight = getScreenPercentSize(context, 100);

    double width = getWidthPercentSize(context, 100) / 8.5;
    double btnHeight = (buttonHeight / 10);
    double fontSize = getPercentSize(btnHeight, 23);

    print("screenSize ====$screenWidth-----$screenHeight--${(btnHeight)}");
    if (screenHeight < screenWidth) {
      fontSize = getPercentSize((btnHeight), 30);
      //   fontSize = getScreenPercentSize(context, 1);
    }

    return InkWell(
      onTap: () {
        numberProvider.pyramidBoxSelection(numPyramidCellModel);
      },
      child: Container(
        // height: (height / 7) * 0.65,
        width: width,

        alignment: Alignment.center,

        decoration: ShapeDecoration(
          gradient: numPyramidCellModel.isHint
              ? LinearGradient(
                  colors: [
                    colorTuple.item1,
                    colorTuple.item1,
                    // darken(colorTuple.item1,0.1)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
          color: numPyramidCellModel.isHint
              ? null
              : (numPyramidCellModel.isDone
                  ? (numPyramidCellModel.isCorrect
                      ? Colors.transparent
                      : Colors.redAccent)
                  : Colors.transparent),
          shape: SmoothRectangleBorder(
            side: BorderSide(
                color:
                    numPyramidCellModel.isActive ? Colors.black : Colors.black,
                // : Theme.of(context).colorScheme.triangleLineColor,
                width: 0.8),
            borderRadius: SmoothBorderRadius(
              cornerRadius: getPercentSize(height, 30),
            ),
          ),
        ),

        child: getTextWidget(
            Theme.of(context).textTheme.titleSmall!.copyWith(
                // color: numPyramidCellModel.isHint
                //     ?  Colors.white
                //     : colorTuple.item1
                color: Colors.black)
            //
            ,
            numPyramidCellModel.isHidden
                ? numPyramidCellModel.text
                : numPyramidCellModel.numberOnCell.toString(),
            TextAlign.center,
            fontSize),

        // child: Text(
        //   numPyramidCellModel.isHidden
        //       ? numPyramidCellModel.text
        //       : numPyramidCellModel.numberOnCell.toString(),
        //   style: Theme.of(context).textTheme.subtitle2!.copyWith(
        //       // color: numPyramidCellModel.isHint
        //       //     ?  Colors.white
        //       //     : colorTuple.item1
        //   color: Colors.black
        //   ),
        // ),
      ),
    );
  }
}
