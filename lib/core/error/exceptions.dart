/// Base class for all exceptions in the application
/// Clean Architecture: Core Layer - Error handling
abstract class AppException implements Exception {
  final String message;
  final String? code;

  AppException({required this.message, this.code});

  @override
  String toString() => 'AppException: $message ${code != null ? '(Code: $code)' : ''}';
}

/// Exception thrown when data source fails
class DataSourceException extends AppException {
  DataSourceException({required String message, String? code})
      : super(message: message, code: code);

  @override
  String toString() => 'DataSourceException: $message';
}

/// Exception thrown when repository fails
class RepositoryException extends AppException {
  RepositoryException({required String message, String? code})
      : super(message: message, code: code);

  @override
  String toString() => 'RepositoryException: $message';
}

/// Exception thrown when use case validation fails
class ValidationException extends AppException {
  ValidationException({required String message, String? code})
      : super(message: message, code: code);

  @override
  String toString() => 'ValidationException: $message';
}

/// Exception thrown when business logic fails
class BusinessException extends AppException {
  BusinessException({required String message, String? code})
      : super(message: message, code: code);

  @override
  String toString() => 'BusinessException: $message';
}

/// Exception thrown when network operation fails
class NetworkException extends AppException {
  NetworkException({required String message, String? code})
      : super(message: message, code: code);

  @override
  String toString() => 'NetworkException: $message';
}

/// Exception thrown when cache operation fails
class CacheException extends AppException {
  CacheException({required String message, String? code})
      : super(message: message, code: code);

  @override
  String toString() => 'CacheException: $message';
}
