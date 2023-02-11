import 'package:littlehelpbook_api/logic/common/error.dart';

/// Service Provider Errors are exceptions raised from the Service Provider
/// Client.
class ServiceProviderError extends LittleHelpBookError {
  ServiceProviderError([String? message, int? statusCode])
      : super(message, 'ServiceProviderError', statusCode);
}
