/// UnhandledError
///
/// Unhandled Error
class UnhandledError implements Exception {
  final String error = 'Terjadi Kesalahan';
  final String message = 'X_X';
  final StackTrace stacktrace = StackTrace.empty;
}

/// ConnectionException
class ConnectionException implements Exception {
  final String error;
  final String message;
  final StackTrace stacktrace;

  ConnectionException({
    this.error = 'Connection Exception',
    this.message = 'X_X',
    this.stacktrace = StackTrace.empty,
  });
}

/// ServerException
class ServerException implements Exception {
  final int statusCode;
  final String error;
  final dynamic message;
  final StackTrace stacktrace;

  ServerException({
    required this.statusCode,
    this.error = 'Server Exception',
    this.message = 'X_X',
    this.stacktrace = StackTrace.empty,
  });
}

/// DataParsingException
class DataParsingException implements Exception {
  final String operation;
  final String error;
  final String message;
  final StackTrace stacktrace;

  DataParsingException({
    required this.operation,
    this.error = 'Data Parsing Exception',
    this.message = 'X_X',
    this.stacktrace = StackTrace.empty,
  });
}
