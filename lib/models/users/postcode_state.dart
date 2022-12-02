class PostcodeState {
  int? id;
  String? name;
  String? nameLong;

  PostcodeState({
    this.id,
    this.name,
    this.nameLong,
  });

  PostcodeState.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameLong = json['name_long'];
  }
}
