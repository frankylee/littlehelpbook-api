import 'package:envied/envied.dart';

part 'app_config.g.dart';

@Envied(obfuscate: true, requireEnvFile: true)
abstract class AppConfig {
  @EnviedField(varName: 'ENV', defaultValue: 'dev')
  static final env = _AppConfig.env;

  static bool get isDev => env.contains('dev');
  static bool get isProd => env.contains('prod');
  static bool get isStage => env.contains('stage');

  @EnviedField(varName: 'AIRTABLE_API_KEY')
  static final airtableApiKey = _AppConfig.airtableApiKey;

  @EnviedField(varName: 'AIRTABLE_BASE_ID')
  static final airtableBaseId = _AppConfig.airtableBaseId;

  @EnviedField(varName: 'INTERNAL_API_KEY')
  static final internalApiKey = _AppConfig.internalApiKey;

  static String toStr() {
    return '''
      AppConfig(
        env: $env
        isDev: $isDev
        isProd: $isProd
        isStage: $isStage
        ---------------------
        airtableApiKey: $airtableApiKey
        airtableBaseId: $airtableBaseId
        internalApiKey: $internalApiKey
      )
    ''';
  }
}
