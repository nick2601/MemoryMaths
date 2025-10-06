import 'package:flutter/material.dart';
import 'package:mathsgames/src/data/models/math_pairs.dart';
import 'package:mathsgames/src/ui/concentration/concentration_provider.dart';
import 'package:mathsgames/src/utility/global_constants.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../soundPlayer/audio_file.dart';

/// A button widget representing a single card in the Concentration game.
/// Displays a pair value and handles user interaction for card matching.
class ConcentrationButton extends StatelessWidget {
  /// The math pair data for this button.
  final Pair mathPairs;
  /// The index of this button in the grid.
  final int index;
  /// Color tuple for styling the button.
  final Tuple2<Color, Color> colorTuple;
  /// Height of the button.
  final double height;
  /// Whether the game is in continue mode (cards can be tapped).
  final bool isContinue;

  /// Creates a ConcentrationButton.
  const ConcentrationButton({
    Key? key,
    required this.mathPairs,
    required this.index,
    required this.height,
    required this.isContinue,
    required this.colorTuple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioPlayer = AudioPlayer(context);
    final radius = getPercentSize(height, 30);

    return AnimatedOpacity(
      opacity: mathPairs.isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 35),
      child: InkWell(
        onTap: () {
          if (isContinue) {
            audioPlayer.playTickSound();
            context.read<ConcentrationProvider>().checkResult(mathPairs, index);
          }
        },
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        child: Container(
          decoration: _getButtonDecoration(context, radius),
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.contain,
            child: getTextWidget(
              Theme.of(context).textTheme.titleMedium!.copyWith(
                color: _getTextColor(),
                fontWeight: FontWeight.bold,
              ),
              mathPairs.text,
              TextAlign.center,
              getPercentSize(height, 20),
            ),
          ),
        ),
      ),
    );
  }

  /// Returns the appropriate decoration based on button state.
  BoxDecoration _getButtonDecoration(BuildContext context, double radius) {
    if (!isContinue) {
      return getDefaultDecorationWithBorder(
        borderColor: Theme.of(context).textTheme.titleSmall!.color,
        radius: radius,
      );
    }

    if (!mathPairs.isActive) {
      return getDefaultDecorationWithGradient(
        radius: radius,
        borderColor: Theme.of(context).textTheme.titleSmall!.color,
        colors: LinearGradient(
          colors: [colorTuple.item2, colorTuple.item2],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );
    }

    return getDefaultDecorationWithBorder(
      borderColor: Theme.of(context).textTheme.titleSmall!.color,
      radius: radius,
    );
  }

  /// Returns the appropriate text color based on button state.
  Color? _getTextColor() {
    if (!isContinue) {
      return null; // Show text when not in continue mode
    }
    if (!mathPairs.isActive) {
      return Colors.transparent; // Hide text when card is face down
    }
    return null; // Show text when card is active/selected
  }
}
