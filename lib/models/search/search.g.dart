// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchService _$SearchServiceFromJson(Map<String, dynamic> json) =>
    SearchService(
      id: json['id'] as int,
      serviceTitle: json['serviceTitle'] as String,
      s: json['s'] as String,
      allTitles: json['allTitles'] as String,
      menuId: json['menu_id'] as int,
      menu: Menu.fromJson(json['menu'] as Map<String, dynamic>),
      matchWord:
          (json['matchWord'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SearchServiceToJson(SearchService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceTitle': instance.serviceTitle,
      's': instance.s,
      'allTitles': instance.allTitles,
      'menu_id': instance.menuId,
      'menu': instance.menu.toJson(),
      'matchWord': instance.matchWord,
    };

Menu _$MenuFromJson(Map<String, dynamic> json) => Menu(
      id: json['id'] as int,
      menuTitle: json['menuTitle'] as String,
    );

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'id': instance.id,
      'menuTitle': instance.menuTitle,
    };
