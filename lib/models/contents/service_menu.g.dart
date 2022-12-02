// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceMenu _$ServiceMenuFromJson(Map<String, dynamic> json) => ServiceMenu(
      id: json['id'] as int,
      agencyId: json['agency_id'] as int,
      serviceReferenceNumber: json['service_reference_number'] as String,
      name: json['name'] as String,
      extraFields: json['extra_fields'] as List<dynamic>,
      matrix: json['matrix'] as List<dynamic>,
      favorite: json['favorite'] as bool,
      agency: Agency.fromJson(json['agency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ServiceMenuToJson(ServiceMenu instance) =>
    <String, dynamic>{
      'id': instance.id,
      'agency_id': instance.agencyId,
      'service_reference_number': instance.serviceReferenceNumber,
      'name': instance.name,
      'extra_fields': instance.extraFields,
      'matrix': instance.matrix,
      'favorite': instance.favorite,
      'agency': instance.agency.toJson(),
    };

Agency _$AgencyFromJson(Map<String, dynamic> json) => Agency(
      id: json['id'] as int,
      name: json['name'] as String,
      logoPath: json['logo_path'],
    );

Map<String, dynamic> _$AgencyToJson(Agency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo_path': instance.logoPath,
    };
