import 'package:fimber/fimber.dart';
import 'package:littlehelpbook_api/logic/airtable/airtable_client.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_error.dart';
import 'package:result_type/result_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider_client.g.dart';

typedef ProviderResult = Result<ServiceProvider, ServiceProviderError>;
typedef ProvidersResult = Result<List<ServiceProvider>, ServiceProviderError>;

/// The Service Provider Client defines the interactions that can be taken when
/// handling a Service Provider in state via an async notifier provider.
@riverpod
class ServiceProviderClient extends _$ServiceProviderClient {
  @override
  Future<ProvidersResult> build() async {
    return _getServiceProviders();
  }

  /// Retrieve all Service Providers from the data source. This method is called
  /// when the provider is created, and may be called as needed to retrieve a
  /// paginated list of 100 Service Providers at a time.
  Future<ProvidersResult> _getServiceProviders() async {
    try {
      final serviceProviders = <ServiceProvider>[];
      final records =
          await ref.read(airtableClientProvider).getAllRecords('Provider');
      for (final r in records) {
        serviceProviders.add(ServiceProvider.fromAirtable(r));
      }
      return Success(serviceProviders);
    } catch (err, stack) {
      Fimber.d('$err', stacktrace: stack);
      return Failure(ServiceProviderError());
    }
  }
}
