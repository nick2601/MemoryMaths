/// Model class representing the user's response to an alert dialog.
/// Tracks the user's decision when presented with game-related alerts.
class AlertResponse {
  /// Whether the user chose to exit the current game
  final bool exit;
  
  /// Whether the user chose to restart the current game
  final bool restart;
  
  /// Whether the user chose to continue playing
  final bool play;

  /// Creates a new AlertResponse instance.
  /// 
  /// Parameters:
  /// - [exit]: True if user wants to exit
  /// - [restart]: True if user wants to restart
  /// - [play]: True if user wants to continue playing
  AlertResponse({
    required this.exit,
    required this.restart, 
    required this.play
  });
}
