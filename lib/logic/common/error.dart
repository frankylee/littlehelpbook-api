import 'dart:io';

/// Little Help Book Errors can be thrown anywhere in the project, allowing
/// errors to be explicitly handled and raised.
///
/// Generally, this is the generic exception that other exceptions should
/// implement in order to provide more explicit exceptions to the consumer.
class LittleHelpBookError implements Exception {
  LittleHelpBookError([String? message, String? error, int? statusCode]) {
    if (message != null) this.message = message;
    if (error != null) this.error = error;
    if (statusCode != null) this.statusCode = statusCode;
  }

  String error = 'LittleHelpBookError';
  String message = 'Internal Server Error';
  int statusCode = HttpStatus.internalServerError;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'error': error,
      'message': message,
      'statusCode': statusCode,
    };
    return data;
  }

  @override
  String toString() {
    return '$error: $message';
  }
}
