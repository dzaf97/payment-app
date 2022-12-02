import 'package:flutter/material.dart';
import 'package:flutterbase/models/users/user.dart';

class UserDataState {
  User data = User(
      id: 0,
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      identityTypeId: 0,
      identityNo: '',
      phoneNo: '',
      citizenship: 0,
      address1: '',
      address2: '',
      address3: '',
      stateId: 0,
      districtId: 0,
      cityId: 0,
      postcode: '',
      agencies: [],
      avatarUrl: '',
      countryId: 0,
      roles: []);
}

class UserState extends ValueNotifier<UserDataState> {
  UserState(UserDataState value) : super(value);

  void clear() {
    value.data = User(
        id: 0,
        firstName: '',
        lastName: '',
        username: '',
        email: '',
        identityTypeId: 0,
        identityNo: '',
        phoneNo: '',
        citizenship: 0,
        address1: '',
        address2: '',
        address3: '',
        stateId: 0,
        districtId: 0,
        cityId: 0,
        postcode: '',
        agencies: [],
        avatarUrl: '',
        countryId: 0,
        roles: []);
    notifyListeners();
  }

  void set(User data) {
    value.data = data;
    notifyListeners();
  }
}
