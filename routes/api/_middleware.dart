import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

/// This middleware acts as an Auth Guard to the `/api` routes. This is to ensure
/// all requests by the consumer are authenticated. If the authentication fails,
/// a `401 UNAUTHORIZED` response is returned.
Handler middleware(Handler handler) {
  return (context) async {
    // Execute code before request is handled.
    if (!context.request.headers.containsKey(HttpHeaders.authorizationHeader)) {
      return Response(statusCode: HttpStatus.unauthorized);
    }
    // Forward the request to the respective handler.
    return await handler(context);
  };
}
