import 'dart:convert';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod/src/framework.dart';
import 'package:test/test.dart';

import '../../../../routes/api/provider/index.dart' as route;
import '../../../logic/provider/service_provider_client_mock.dart';
import '../../../logic/provider_container_mock.dart';

class _MockRequestContext extends Mock implements RequestContext {}

void main() {
  const requestUri = 'http://localhost/api/provider';

  group('GET /api/provider', () {
    late _MockRequestContext context;
    late Request request;
    late StubServiceProviderNotifier serviceProvider;
    late ProviderContainer container;

    setUp(() {
      context = _MockRequestContext();
      request = Request.get(Uri.parse(requestUri));
      serviceProvider = StubServiceProviderNotifier();
      container = overrideProviderContainer(serviceProvider: serviceProvider);

      when(() => context.request).thenReturn(request);
      when(context.read<ProviderContainer>).thenReturn(container);
    });

    test('responds with a 200 and list of Providers.', () async {
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.ok));
      expect(
        await response.body(),
        equalsIgnoringWhitespace(
          jsonEncode([serviceProvider.buildServiceProvider().toJson()]),
        ),
      );
    });

    test('responds with a 404 and a Service Provider Error.', () async {
      serviceProvider.testAction(isSuccess: false);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.notFound));
      expect(
        await response.body(),
        equalsIgnoringWhitespace(
          jsonEncode(ServiceProviderError.notFound().toJson()),
        ),
      );
    });

    test('responds with a 500 and an Internal Server Error.', () async {
      serviceProvider.testAction(shouldThrow: true);
      final response = await route.onRequest(context);
      expect(response.statusCode, equals(HttpStatus.internalServerError));
      expect(
        await response.body(),
        equalsIgnoringWhitespace(jsonEncode(ServiceProviderError().toJson())),
      );
    });
  });
}
