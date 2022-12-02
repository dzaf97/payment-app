class District {
  int? id;
  int? stateId;
  String? name;
  String? code3;

  District(
    List data, {
    this.id,
    this.stateId,
    this.name,
    this.code3,
  });

  District.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stateId = json['state_id'];
    name = json['name'];
    code3 = json['code3'];
  }
}
