import 'package:json_annotation/json_annotation.dart';
part 'search.g.dart';

@JsonSerializable(explicitToJson: true)
class SearchService {
  SearchService({
    required this.id,
    required this.serviceTitle,
    required this.s,
    required this.allTitles,
    required this.menuId,
    required this.menu,
    required this.matchWord,
  });

  int id;
  String serviceTitle;
  String s;
  String allTitles;
  @JsonKey(name: "menu_id")
  int menuId;
  Menu menu;
  List<String> matchWord;

  factory SearchService.fromJson(Map<String, dynamic> json) =>
      _$SearchServiceFromJson(json);

  Map<String, dynamic> toJson() => _$SearchServiceToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Menu {
  Menu({
    required this.id,
    required this.menuTitle,
  });

  int id;
  String menuTitle;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);

  Map<String, dynamic> toJson() => _$MenuToJson(this);
}
