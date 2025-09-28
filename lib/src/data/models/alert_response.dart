import 'package:hive/hive.dart';

part 'alert_response.g.dart';

@HiveType(typeId: 1) // Make sure it's unique!
class AlertResponse {
  @HiveField(0)
  final bool exit;

  @HiveField(1)
  final bool restart;

  @HiveField(2)
  final bool play;

  AlertResponse({
    required this.exit,
    required this.restart,
    required this.play,
  });
}