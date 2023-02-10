import 'package:dart_airtable/dart_airtable.dart';
import 'package:littlehelpbook_api/config/app_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'airtable_client.g.dart';

@riverpod
Airtable airtableClient(AirtableClientRef ref) {
  return Airtable(
    apiKey: AppConfig.airtableApiKey,
    projectBase: AppConfig.airtableBaseId,
  );
}
