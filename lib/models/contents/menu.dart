class Menu {
  late int id;
  late int? lft;
  late int? rgt;
  late int? depth;
  late int? parentId;
  late String name;
  late String? type;
  late String? icon;

  Menu(
      {required this.id,
      this.lft,
      this.rgt,
      this.depth,
      this.parentId,
      required this.name,
      this.type,
      this.icon});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lft = json['lft'];
    rgt = json['rgt'];
    depth = json['depth'];
    parentId = json['parent_id'] ?? 0;
    name = json['name'];
    type = json['type'];
    icon = json['icon'] ?? '';
  }
}
