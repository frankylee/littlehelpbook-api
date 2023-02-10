import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_provider_error.freezed.dart';

@freezed
class ServiceProviderError with _$ServiceProviderError {
  factory ServiceProviderError.unexpectedError() = _UnexpectedError;
}
