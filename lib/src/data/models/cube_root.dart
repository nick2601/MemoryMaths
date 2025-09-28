import 'package:hive/hive.dart';

part 'cube_root.g.dart';

@HiveType(typeId: 7)
class CubeRoot {
  @HiveField(0)
  final String question;

  @HiveField(1)
  final String firstAns;

  @HiveField(2)
  final String secondAns;

  @HiveField(3)
  final String thirdAns;

  @HiveField(4)
  final String fourthAns;

  @HiveField(5)
  final int answer;

  const CubeRoot({
    required this.question,
    required this.firstAns,
    required this.secondAns,
    required this.thirdAns,
    required this.fourthAns,
    required this.answer,
  });

  @override
  String toString() =>
      'CubeRoot(question: $question, firstAns: $firstAns, '
          'secondAns: $secondAns, thirdAns: $thirdAns, '
          'fourthAns: $fourthAns, answer: $answer)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CubeRoot &&
              runtimeType == other.runtimeType &&
              question == other.question &&
              answer == other.answer;

  @override
  int get hashCode => Object.hash(question, answer);
}