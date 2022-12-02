class States {
  int? id;
  int? countryId;
  String? name;
  String? nameLong;
  String? code2;
  String? code3;
  String? capital;

  States(
    List data, {
    this.id,
    this.countryId,
    this.name,
    this.nameLong,
    this.code2,
    this.code3,
  });

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryId = json['country_id'];
    name = json['name'];
    nameLong = json['nameLong'];
    code2 = json['code2'];
    code3 = json['code3'];
    capital = json['capital'];
  }
}
