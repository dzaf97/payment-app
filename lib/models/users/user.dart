import 'package:flutterbase/models/users/identity_type.dart';

class User {
  int? id;
  String? firstName;
  String? lastName;
  String? username;
  String? email;
  int? identityTypeId;
  String? identityNo;
  String? phoneNo;
  int? citizenship;
  String? address1;
  String? address2;
  String? address3;
  int? countryId;
  int? stateId;
  int? districtId;
  int? cityId;
  String? postcode;
  List<dynamic>? agencies;
  String? avatarUrl;
  List<dynamic>? roles;
  IdentityType? getIdentityType;
  String? stateName;
  String? districtName;
  String? cityName;
  GetPassport? passport;
  int? countryNationalityId;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.identityTypeId,
    this.identityNo,
    this.phoneNo,
    this.citizenship,
    this.address1,
    this.address2,
    this.address3,
    this.countryId,
    this.stateId,
    this.districtId,
    this.cityId,
    this.postcode,
    this.agencies,
    this.avatarUrl,
    this.roles,
    this.stateName,
    this.districtName,
    this.cityName,
    this.countryNationalityId,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    username = json['username'];
    email = json['email'];
    identityTypeId = json['user_identity_type_id'];
    identityNo = json['ic_no'];
    phoneNo = json['phone_no'];
    citizenship = json['citizenship'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    address3 = json['address_3'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    districtId = json['district_id'];
    cityId = json['city_id'];
    postcode = json['postcode'];
    agencies = json['agencies'];
    avatarUrl = json['avatar_url'];
    roles = json['roles'];
    stateName = json['state_name'];
    districtName = json['district_name'];
    cityName = json['city_name'];
    countryNationalityId = json['country_nationality_id'];
    getIdentityType = IdentityType.fromJson(json['user_identity_type']);
    if(json.containsKey('passport') && json['passport'] != null) {
      passport = GetPassport.fromJson(json['passport']);
    }
  }
}

class GetPassport {
  int? id;
  String? passportNo;
  String? passportEndDate;

  GetPassport({
    this.id,
    this.passportNo,
    this.passportEndDate,
  });

  GetPassport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    passportNo = json['passport_no'] ?? '';
    passportEndDate = json['passport_end_date'] ?? '';
  }
}
