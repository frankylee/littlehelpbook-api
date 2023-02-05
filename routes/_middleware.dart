import 'package:dart_frog/dart_frog.dart';
import 'package:riverpod/riverpod.dart';

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(providerContainer());
}

/// This injects the Riverpod Provider Container into all the route handlers,
/// allowing access to all providers as needed.
Middleware providerContainer() {
  return provider<ProviderContainer>((ctx) => ProviderContainer());
}
