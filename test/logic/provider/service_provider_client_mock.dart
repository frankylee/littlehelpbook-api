import 'dart:async';

import 'package:littlehelpbook_api/logic/provider/service_provider.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_client.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_error.dart';
import 'package:result_type/result_type.dart';

const mockServiceProviderId = 'provider_BwZyWD1S3Pqi9';

/// A stubbed Service Provider Notifier for testing purposes. This allows the
/// notifier to be easily integrated into tests.
class StubServiceProviderNotifier extends ServiceProviderNotifier {
  bool _isSuccess = true;
  bool _shouldThrow = false;

  @override
  FutureOr<ProvidersResult> build() async {
    if (_shouldThrow) throw ServiceProviderError();
    return _isSuccess
        ? Success([buildServiceProvider()])
        : Failure(ServiceProviderError.notFound());
  }

  @override
  FutureOr<ProviderResult> getOneByIdOrFail(String id) async {
    if (_shouldThrow) throw ServiceProviderError();
    return _isSuccess
        ? Success(buildServiceProvider(id: id))
        : Failure(ServiceProviderError.notFound());
  }

  void testAction({bool? isSuccess, bool? shouldThrow}) {
    if (isSuccess != null) _isSuccess = isSuccess;
    if (shouldThrow != null) _shouldThrow = shouldThrow;
  }

  ServiceProvider buildServiceProvider({String? id}) {
    return ServiceProvider(
      id: id ?? mockServiceProviderId,
      lastModified: '2023-02-12T02:20:50.000Z',
      name: 'Generic Service Provider',
    );
  }
}
