class PostcodeCity {
  int? id;
  String? name;

  PostcodeCity({
    this.id,
    this.name,
  });

  PostcodeCity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
