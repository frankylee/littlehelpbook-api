import 'package:fimber/fimber.dart';
import 'package:littlehelpbook_api/logic/airtable/airtable_client.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_error.dart';
import 'package:result_type/result_type.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'service_provider_client.g.dart';

typedef ProviderResult = Result<ServiceProvider, ServiceProviderError>;
typedef ProvidersResult = Result<List<ServiceProvider>, ServiceProviderError>;

@riverpod
class ServiceProviderClient extends _$ServiceProviderClient {
  @override
  Future<ProvidersResult> build() async {
    return _getServiceProviders();
  }

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
      Fimber.d('$err $stack');
      return Failure(ServiceProviderError.unexpectedError());
    }
  }
}
