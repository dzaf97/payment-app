class Organization {
  int? id;
  String? orgEmail;
  String? orgName;
  int? orgTypeId;
  int? userId;
  String? orgRegistrationNo;
  String? dateExtablished;
  int? stateId;
  String? address1;
  String? address2;
  String? address3;
  String? postcode;
  int? districtId;
  int? cityId;
  String? phoneNo;

  Organization(
    List data, {
    this.id,
    this.orgEmail,
    this.orgTypeId,
    this.userId,
    this.orgRegistrationNo,
    this.dateExtablished,
    this.stateId,
    this.address1,
    this.address2,
    this.address3,
    this.postcode,
    this.districtId,
    this.cityId,
    this.phoneNo,
  });

  Organization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orgEmail = json['org_email'];
    orgName = json['org_name'];
    orgTypeId = json['org_type_id'];
    userId = json['user_id'];
    orgRegistrationNo = json['org_registration_no'];
    dateExtablished = json['date_extablished'];
    stateId = json['state_id'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    postcode = json['postcode'];
    districtId = json['district_id'];
    cityId = json['city_id'];
    phoneNo = json['phone_no'];
  }
}
