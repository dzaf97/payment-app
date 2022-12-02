class ListOrganizationMember {
  int? id;
  int? orgId;
  int? userId;
  GetUser? user;

  ListOrganizationMember(List data, {this.id, this.orgId, this.userId});

  ListOrganizationMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgId = json['org_id'];
    userId = json['user_id'];
    user = GetUser.fromJson(json['user']);
  }
}

class GetUser {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;

  GetUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
  });

  GetUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'] ?? '';
    lastName = json['last_name'] ?? '';
    email = json['email'] ?? '';
    role = json['role'] ?? '';
  }
}
