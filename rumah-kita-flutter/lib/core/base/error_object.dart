import 'package:equatable/equatable.dart';

import 'base.dart';

/// ErrorObject
///
/// End-user error object
class ErrorObject extends Equatable {
  /// Raw error in `lower_and_snake_case` form
  final String error;

  /// End-user error label
  final String label;

  /// End-user error message
  final String message;

  const ErrorObject({
    this.error = 'error',
    this.label = 'Terjadi Kesalahan!',
    this.message = 'X_X',
  });

  @override
  List<Object?> get props => [error, label, message];

  static ErrorObject mapExceptionToErrMsg(Exception e) {
    if (e is ConnectionException) {
      return ErrorObject(
        error: 'connection_exception',
        label: 'Error Code: CONNECTION_EXCEPTION',
        message: e.message,
      );
    } else if (e is ServerException) {
      return ErrorObject(
        error: 'server_exception',
        label: 'Error Code: SERVER_EXCEPTION',
        message: e.message,
      );
    } else if (e is DataParsingException) {
      return ErrorObject(
        error: 'data_parsing_exception',
        label: 'Error Code: DATA_PARSING_EXCEPTION',
        message: e.message,
      );
    } else {
      return const ErrorObject();
    }
  }

  ErrorObject copyWith({
    String? error,
    String? label,
    String? message,
  }) {
    return ErrorObject(
      error: error ?? this.error,
      label: label ?? this.label,
      message: message ?? this.message,
    );
  }
}
