import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:littlehelpbook_api/config/app_config.dart';

/// This middleware acts as an Auth Guard to the `/api` routes. This is to ensure
/// all requests by the consumer are authenticated. If the authentication fails,
/// a `401 UNAUTHORIZED` response is returned.
Handler middleware(Handler handler) {
  return (context) async {
    final headers = context.request.headers;
    if (headers[HttpHeaders.authorizationHeader] != AppConfig.internalApiKey) {
      return Response(statusCode: HttpStatus.unauthorized);
    }
    return await handler(context);
  };
}
