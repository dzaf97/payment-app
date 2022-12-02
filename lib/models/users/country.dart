class Country {
  int? id;
  String? name;
  String? iso_3166_2;
  String? iso_3166_3;

  Country(
    List data, {
    this.id,
    this.name,
    this.iso_3166_2,
    this.iso_3166_3,
  });

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] ?? '';
    iso_3166_2 = json['iso_3166_2'] ?? '';
    iso_3166_3 = json['iso_3166_3'] ?? '';
  }
}
