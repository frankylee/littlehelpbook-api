import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:fimber/fimber.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_client.dart';
import 'package:littlehelpbook_api/logic/provider/service_provider_error.dart';
import 'package:riverpod/riverpod.dart';

Future<Response> onRequest(RequestContext context) async {
  switch (context.request.method) {
    case HttpMethod.get:
      return _get(context);
    case HttpMethod.post:
    case HttpMethod.delete:
    case HttpMethod.head:
    case HttpMethod.options:
    case HttpMethod.patch:
    case HttpMethod.put:
      return Response(statusCode: HttpStatus.methodNotAllowed);
  }
}

/// Retrieve a list of 100 Service Providers from the datastore. While Airtable
/// supports pagination, the underlying Airtable client library does not. This
/// means that current implementation is limited to the 100 records.
///
/// This is acceptable for right now, but will need to be addressed as
/// development increases.
Future<Response> _get(RequestContext context) async {
  try {
    final result = await context
        .read<ProviderContainer>()
        .read(serviceProviderProvider.future);
    return result.isSuccess
        ? Response.json(body: result.success)
        : Response.json(
            body: result.failure,
            statusCode: result.failure.statusCode,
          );
  } catch (err, stack) {
    Fimber.d(err.toString(), stacktrace: stack);
    return Response.json(
      statusCode: HttpStatus.internalServerError,
      body: ServiceProviderError(),
    );
  }
}
