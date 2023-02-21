import 'package:littlehelpbook_api/logic/provider/service_provider_client.dart';
import 'package:riverpod/riverpod.dart';
import 'package:test/test.dart';

import 'provider/service_provider_client_mock.dart';

/// A test helper to override the Provider Container with mocked or stubbed
/// providers. This allows the providers to be easily manipulated for the test.
///
/// The Provider Container will be disposed after each test.
ProviderContainer overrideProviderContainer({
  StubServiceProviderNotifier? serviceProvider,
}) {
  final container = ProviderContainer(
    overrides: [
      if (serviceProvider != null)
        serviceProviderProvider.overrideWith(() => serviceProvider),
    ],
  );
  addTearDown(container.dispose);
  return container;
}
