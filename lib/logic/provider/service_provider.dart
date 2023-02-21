import 'package:dart_airtable/dart_airtable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:littlehelpbook_api/logic/common/type_helpers.dart';

part 'service_provider.freezed.dart';
part 'service_provider.g.dart';

@freezed
class ServiceProvider with _$ServiceProvider {
  const factory ServiceProvider({
    required String id,
    required String lastModified,
    required String name,
    String? descEn,
    String? descEs,
    String? email,
    List<String>? locations,
    String? phone,
    List<String>? services,
    String? website,
  }) = _ServiceProvider;

  factory ServiceProvider.fromJson(Map<String, dynamic> json) =>
      _$ServiceProviderFromJson(json);

  factory ServiceProvider.fromAirtable(AirtableRecord record) {
    return ServiceProvider(
      id: record.id!,
      lastModified: record.createdTime!.toIso8601String(),
      name: record.getField('name')!.value.toString(),
      services: formatList<Object, String>(
        record.getField('fk_service_id')?.value,
      ),
      descEn: record.getField('description_en')?.value.toString(),
      descEs: record.getField('description_es')?.value.toString(),
      email: record.getField('email')?.value.toString(),
      locations: formatList<Object, String>(
        record.getField('fk_location_id')?.value,
      ),
      phone: record.getField('phone')?.value.toString(),
      website: record.getField('website')?.value.toString(),
    );
  }
}
