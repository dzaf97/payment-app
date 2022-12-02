class OrganizationType {
  int? id;
  String? category;
  String? type;
  int? characterCount;

  OrganizationType({this.id, this.category, this.type, this.characterCount});

  OrganizationType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    type = json['type'];
    characterCount = json['character_count'];
  }
}
