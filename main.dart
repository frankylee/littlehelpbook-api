import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:fimber/fimber.dart';
import 'package:littlehelpbook_api/config/app_config.dart';

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // If not in production, initialize Fimber logging.
  if (!AppConfig.isProd) Fimber.plantTree(DebugTree());
  Fimber.d('APP CONFIG: ${AppConfig.toStr()}');
  return serve(handler, ip, port);
}
