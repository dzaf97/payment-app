class Submenu {
  late int id;
  late String name;
  late String icon;

  Submenu({required this.id, required this.name, required this.icon});

  Submenu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'] ?? '';
  }
}
