/// Class representing a failure in the application
/// Clean Architecture: Core Layer - Error handling
abstract class Failure {
  final String message;
  final String? code;

  Failure({required this.message, this.code});

  @override
  String toString() => 'Failure: $message ${code != null ? '(Code: $code)' : ''}';
}

/// Failure from data source
class DataSourceFailure extends Failure {
  DataSourceFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Failure from repository
class RepositoryFailure extends Failure {
  RepositoryFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Failure from validation
class ValidationFailure extends Failure {
  ValidationFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Failure from business logic
class BusinessFailure extends Failure {
  BusinessFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Failure from network
class NetworkFailure extends Failure {
  NetworkFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Failure from cache
class CacheFailure extends Failure {
  CacheFailure({required String message, String? code})
      : super(message: message, code: code);
}

/// Generic server failure
class ServerFailure extends Failure {
  ServerFailure({required String message, String? code})
      : super(message: message, code: code);
}
