class IdentityType {
  int? id;
  String? category;
  String? type;
  int? characterCount;

  IdentityType(
    List data, {
    this.id,
    this.category,
    this.type,
    this.characterCount,
  });

  IdentityType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] ?? '';
    type = json['type'] ?? '';
    characterCount = json['character_count'] ?? '';
  }
}
