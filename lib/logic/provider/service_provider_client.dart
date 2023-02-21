import 'package:dart_airtable/dart_airtable.dart';
import 'package:fimber/fimber.dart';
import 'package:littlehelpbook_api/config/app_config.dart';
import 'package:littlehelpbook_api/logic/airtable/airtable_client.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_error.dart';
import 'package:result_type/result_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

typedef ProviderResult = Result<ServiceProvider, ServiceProviderError>;
typedef ProvidersResult = Result<List<ServiceProvider>, ServiceProviderError>;

/// The Service Provider provider permits interactions with a Service Provider
/// in state via an async notifier.
final serviceProviderProvider =
    AsyncNotifierProvider<ServiceProviderNotifier, ProvidersResult>(() {
  return ServiceProviderNotifier();
});

/// The Service Provider notifier defines the interactions that can be taken
/// when handling a Service Provider within state.
class ServiceProviderNotifier extends AsyncNotifier<ProvidersResult> {
  final String tableId = AppConfig.airtableProviderId;

  @override
  FutureOr<ProvidersResult> build() async {
    return getServiceProviders();
  }

  /// Retrieve all Service Providers from the data source. This method is called
  /// when the provider is created, and may be called as needed to retrieve a
  /// paginated list of 100 Service Providers at a time.
  FutureOr<ProvidersResult> getServiceProviders() async {
    try {
      if (state.valueOrNull != null) return state.value!;
      final serviceProviders = <ServiceProvider>[];
      final records =
          await ref.read(airtableClientProvider).getAllRecords(tableId);
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
