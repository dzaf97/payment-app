import 'package:dio/dio.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/contents/menu.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/models/organizations/list_organization_member.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/models/organizations/organization_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/country.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/models/users/user.dart';
import 'package:flutterbase/states/app_state.dart';
import '../utils/helpers.dart';

class ErrorResponse {
  bool isSuccessful;
  String message;
  dynamic data;

  ErrorResponse(this.isSuccessful, this.message, {this.data});
}

class Api {
  String endpoint = 'https://ipayment.phgo.xyz';
  // String endpoint = 'https://internalstag-ipayment.anm.gov.my';
  String token = '';
  String path = '';

  Api();

  //  Dio client() {
  //   var dio = Dio(
  //     BaseOptions(
  //       baseUrl: endpoint,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': token.isNotEmpty ? 'Bearer ' + token : '',
  //       },
  //     ),
  //   );

  //   (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
  //       (HttpClient client) {
  //     client.badCertificateCallback =
  //         (X509Certificate cert, String host, int port) => true;
  //     return client;
  //   };
  //   return dio;
  // }

  Dio client() {
    return Dio(
      BaseOptions(
        baseUrl: endpoint,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': token.isNotEmpty ? 'Bearer ' + token : '',
        },
      ),
    );
  }

  // When app refresh
  Future<bool> resume() async {
    String _token = store.getItem('token').toString();
    String _path = store.getItem('path').toString();
    print(_path);
    print(_token);
    if (_token != 'null') {
      token = _token;
      try {
        await setupContents();
        await setupUser();
        return true;
      } on DioError catch (e) {
        print(e.message);
      }
      token = '';
    }
    return false;
  }

  // Calling function on resume
  Future boot() async {
    await resume();
  }

  Future<ErrorResponse> searchService(String query) async {
    var response = await client().get(
      '/api/services/predict',
      queryParameters: {"s": query},
      options: Options(
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    if (response.data['message'] == 'Successful') {
      return ErrorResponse(true, '', data: response.data["data"]);
    } else {
      return ErrorResponse(
        false,
        response.data["message"],
        data: response.data["data"],
      );
    }
  }

  // Payment gateway for cybersource
  Future<Uri> pay(double amount, String serviceCode) async {
    var response = await client().post(
      '/api/services/$serviceCode/pay',
      data: {
        'amount': amount,
      },
    );

    return Uri.parse(response.data!['data']['redirect']);
  }

  // Get list of menu
  Future<List<Menu>> setupContents() async {
    List<Menu> menus = [];
    try {
      var response = await client().get('/api/menu');
      // print(response);
      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          menus.add(Menu.fromJson(item));
        }
        state.value.menuState.set(menus);
      }
    } on DioError catch (_) {}
    return menus;
  }

  // Ge t list of submenu
  Future<List<Menu>> getSubmenu(int getMenuByParentId) async {
    List<Menu> list = [];
    try {
      var response = await client()
          .get('/api/menu/?parent_id=' + getMenuByParentId.toString());
      print(response.data['data']);
      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(Menu.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get term & condition
  Future<ErrorResponse> getTermAndCondition(int getMenuId) async {
    try {
      var response =
          await client().get('/api/services/menu/' + getMenuId.toString());
      print(response);

      if (response.data['message'] == 'Successful') {
        print('Data get successfully');
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Get service detail by id
  Future<ErrorResponse> getServiceDetail(int serviceRefNum) async {
    try {
      var response =
          await client().get('/api/services/' + serviceRefNum.toString());
      // print(response);

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '', data: response.data["data"]);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Get service menu
  Future<ErrorResponse> getServicesForMenu(int getMenuId) async {
    try {
      var response =
          await client().get('/api/services/menu/' + getMenuId.toString());
      print(response);

      if (response.data['message'] == 'Successful') {
        print('Data get successfully');
        return ErrorResponse(true, '', data: response.data["data"]);
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Login
  Future<ErrorResponse> login(String username, String password) async {
    try {
      var response = await client().post(
        '/api/auth/login',
        data: {
          'email': username,
          'password': password,
        },
      );
      if (response.data['message'] == 'Successful') {
        token = response.data['data']['access_token'];
        await store.setItem('token', token);
        await setupContents();
        await setupUser();
        await setupContents();
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Set user state
  Future<void> setupUser() async {
    var response = await client().get('/api/user');
    state.setUser(User.fromJson(
        response.data['data']['profile'] as Map<String, dynamic>));
  }

  // Forgot password
  Future<ErrorResponse> forgotPassword(String email) async {
    try {
      var response = await client().post(
        '/api/auth/forgot-password',
        data: {
          'email': email,
        },
      );
      if (response.statusCode == 200) {
        print('We have emailed your password reset link!');
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data['errors']['email']);

      return ErrorResponse(
          false,
          e.response!.data['errors']['email']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }

    return ErrorResponse(false, 'Unknown API error');
  }

  // Forgot userID
  Future<ErrorResponse> forgotUserID(
      String userID, int userIdentityTypeId) async {
    try {
      var response = await client().get('/api/auth/forgot-userid/' +
          userID +
          '?user_identity_type_id=' +
          userIdentityTypeId.toString());
      if (response.data['message'] == 'Successful') {
        await store.setItem('getUserID', response.data['data']['email']);
        print(store.getItem('getUserID').toString());

        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data['errors']);

      return ErrorResponse(
          false,
          e.response!.data['errors']['ic_no']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }

    return ErrorResponse(false, 'Unknown API error');
  }

  // Register
  Future<ErrorResponse> register(
    String email,
    bool isBanned,
    String firstName,
    String lastName,
    int citizenship,
    String identityNo,
    int countryID,
    int? stateID,
    String address1,
    String address2,
    String address3,
    String postcodeId,
    int? districtID,
    int? cityID,
    String phoneNo,
    bool isCheckedTnc,
    String password,
    String passwordConfirmation,
    int identityTypeID,
    String identityEndDate,
    String stateName,
    String districtName,
    String cityName,
    int? countryNationalityId,
  ) async {
    try {
      var response = await client().post('/api/auth/register', data: {
        'email': email,
        'is_banned': isBanned,
        'first_name': firstName,
        'last_name': lastName,
        'citizenship': citizenship,
        'identity_no': identityNo,
        'country_id': countryID,
        'state_id': stateID,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'postcode': postcodeId,
        'district_id': districtID,
        'city_id': cityID,
        'phone_no': phoneNo,
        'tnc': isCheckedTnc,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'user_identity_type_id': identityTypeID,
        'identity_end_date': identityEndDate,
        'state_name': stateName,
        'district_name': districtName,
        'city_name': cityName,
        'country_nationality_id': countryNationalityId,
      });

      print(response);

      if (response.data['message'] == 'Successful') {
        var token = response.data['data']['access_token'];
        await store.setItem('token', token);
        await store.setItem('registerPath', response.data['data']['path']);
        await resume();
        print('Register success');
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(false, e.response!.data['errors'].toString());
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Verify code send by email
  Future<ErrorResponse> verifyEmailOTP(String code, String path) async {
    try {
      var response = await client().post(
        '/api/auth/verify',
        data: {
          'code': code,
          'path': path,
        },
      );

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
      return ErrorResponse(
          false, e.response!.data['errors']['code'].toString());
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Resend OTP to email
  Future<bool> resendEmailOTP(String email) async {
    try {
      var response = await client().post(
        '/api/auth/resend',
        data: {
          'email': email,
        },
      );

      print(response);

      if (response.data['message'] == 'Successful') {
        token = response.data['data']['access_token'];
        await store.setItem('token', token);
        await setupUser();
        return true;
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
    }
    return false;
  }

  // Reset password
  Future<bool> resetPassword(String token, String email, String password,
      String passwordConfirmation) async {
    try {
      var response = await client().post(
        '/api/auth/reset-password',
        data: {
          'token': token,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );
      print(response);
      if (response.data['message'] == 'Successful') {
        print('We have emailed your password reset link!');
        return true;
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
    }
    return false;
  }

  // Change password
  Future<ErrorResponse> changePassword(
    String currentPasssword,
    String passsword,
    String passwordConfirmation,
  ) async {
    try {
      var response = await client().post(
        '/api/user/change-password',
        data: {
          'current_password': currentPasssword,
          'new_password': passsword,
          'new_password_confirmation': passwordConfirmation,
        },
      );
      print(response);
      if (response.data['message'] == 'Successful') {
        print('Tukar kata laluan berjaya');
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(false, e.response!.data['errors'].toString());
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Update profile
  Future<ErrorResponse> updateProfile(
    String firstName,
    String lastName,
    String email,
    String phoneNo,
    int citizenship,
    String address1,
    String? address2,
    String? address3,
    int? stateId,
    int? districtId,
    int? cityId,
    String postcode,
    int? identityTypeId,
    String? identityNo,
  ) async {
    try {
      var response = await client().post('/api/user/', data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_no': phoneNo,
        'citizenship': citizenship,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'state_id': stateId,
        'district_id': districtId,
        'city_id': cityId,
        'postcode': postcode,
        'identity_type_id': identityTypeId,
        'identity_no': identityNo,
      });

      if (response.data['message'] == 'Profil anda telah dikemas kini.') {
        await setupUser();
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(false, e.response!.data['errors'].toString());
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Get country
  Future<List<Country>> getCountry() async {
    List<Country> list = [];
    try {
      var response = await client().get('/api/config/countries_states/');

      if (response.data['data'] != null) {
        for (var item in response.data['data']['countries']) {
          list.add(Country.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get states
  Future<List<States>> getStates() async {
    List<States> list = [];
    try {
      var response = await client().get('/api/config/countries_states/');

      if (response.data['data'] != null) {
        for (var item in response.data['data']['states']) {
          list.add(States.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get district
  Future<List<District>> getDistrict(int? stateID) async {
    List<District> list = [];
    try {
      var response = await client()
          .get('/api/config/districts/?state_id=' + stateID.toString());

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(District.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get city
  Future<List<City>> getCity() async {
    List<City> list = [];
    try {
      var response = await client().get('/api/config/cities');

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(City.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get postcode for state & city
  Future<List<PostcodeState>> getPostcodeState(String postcode) async {
    List<PostcodeState> list = [];

    try {
      var response = await client().get('/api/config/postcodes/' + postcode);
      if (response.data['data'].isNotEmpty) {
        list.add(PostcodeState.fromJson(response.data['data']['state']));
      } else {
        print('State is null');
        // getStates();
      }
    } on DioError catch (_) {}
    return list;
  }

  Future<List<PostcodeCity>> getPostcodeCity(String postcode) async {
    List<PostcodeCity> list = [];
    try {
      var response = await client().get('/api/config/postcodes/' + postcode);

      if (response.data['data'].isNotEmpty) {
        for (var item in response.data['data']['cities']) {
          list.add(PostcodeCity.fromJson(item));
        }
      } else {
        print('City is null');
        // getCity();
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get identity type all
  Future<List<IdentityType>> getIndentityTypeAll() async {
    List<IdentityType> list = [];
    try {
      var response = await client().get('/api/user-identity-types/individual');
      if (response.data['data'] != null) {
        for (var item in response.data['data']['citizen']) {
          list.add(IdentityType.fromJson(item));
        }
        for (var item in response.data['data']['non_citizen']) {
          list.add(IdentityType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get identity type for netizen
  Future<List<IdentityType>> getIndentityType() async {
    List<IdentityType> list = [];
    try {
      var response = await client().get('/api/user-identity-types/individual');
      // print(response);
      if (response.data['data'] != null) {
        for (var item in response.data['data']['citizen']) {
          list.add(IdentityType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get identity type for non-netizen
  Future<List<IdentityType>> getIndentityTypeNonCitezen() async {
    List<IdentityType> list = [];
    try {
      var response = await client().get('/api/user-identity-types/individual');
      if (response.data['data'] != null) {
        for (var item in response.data['data']['non_citizen']) {
          list.add(IdentityType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get list of organization member
  Future<List<ListOrganizationMember>> getOrganizationMember(int oId) async {
    List<ListOrganizationMember> list = [];
    try {
      var response = await client().get('/api/organizations/' + oId.toString());

      if (response.data['data'] != null) {
        for (var item in response.data['data']['members']) {
          list.add(ListOrganizationMember.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get list of organization admin
  Future<List<Organization>> getOrganization() async {
    List<Organization> list = [];
    try {
      var response = await client().get('/api/organizations');

      if (response.data['data'] != null) {
        for (var item in response.data['data']) {
          list.add(Organization.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get organization type
  Future<List<OrganizationType>> getOrganizationType() async {
    List<OrganizationType> list = [];
    try {
      var response =
          await client().get('/api/user-identity-types/organization');

      if (response.data['message'] == 'Successful') {
        for (var item in response.data['data']) {
          list.add(OrganizationType.fromJson(item));
        }
      } else {
        for (var item in response.data['data']) {
          list.add(OrganizationType.fromJson(item));
        }
      }
    } on DioError catch (_) {}
    return list;
  }

  // Get organization detail
  Future<ErrorResponse> organizationDetail(
    int userId,
    String orgName,
    String orgEmail,
    int orgTypeId,
    String orgRegistrationNo,
    String dateExtablished,
    String address1,
    String address2,
    String address3,
    String postcode,
    int stateId,
    int districtId,
    int cityId,
    String? phoneNo,
  ) async {
    try {
      var response = await client().post('/api/organizations', data: {
        'user_id': userId,
        'org_name': orgName,
        'org_email': orgEmail,
        'org_type_id': orgTypeId,
        'org_registration_no': orgRegistrationNo,
        'date_extablished': dateExtablished,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'postcode': postcode,
        'state_id': stateId,
        'district_id': districtId,
        'city_id': cityId,
        'phone_no': phoneNo,
      });

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(false, e.response!.data['errors'].toString());
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Update organization
  Future<ErrorResponse> updateOrganization(
    int orgId,
    String orgName,
    String orgEmail,
    int orgTypeId,
    String orgRegistrationNo,
    String dateExtablished,
    String address1,
    String address2,
    String address3,
    String postcode,
    int stateId,
    int districtId,
    int cityId,
    String? phoneNo,
  ) async {
    try {
      var response =
          await client().put('/api/organizations/' + orgId.toString(), data: {
        'org_name': orgName,
        'org_email': orgEmail,
        'org_type_id': orgTypeId,
        'org_registration_no': orgRegistrationNo,
        'date_extablished': dateExtablished,
        'address_1': address1,
        'address_2': address2,
        'address_3': address3,
        'postcode': postcode,
        'state_id': stateId,
        'district_id': districtId,
        'city_id': cityId,
        'phone_no': phoneNo,
      });

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['message']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Delete organization
  Future<ErrorResponse> organizationDeleted(
    int? oId,
  ) async {
    try {
      var response =
          await client().delete('/api/organizations/' + oId.toString());

      if (response.data['message'] == 'Successful') {
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(false, e.response!.data['errors'].toString());
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }

  // Add member to organization
  Future<ErrorResponse> addMember(int orgId, List<String> icNo) async {
    try {
      var response = await client().post(
        '/api/organizations/add-member',
        data: {
          'org_id': orgId,
          'ic_no': icNo,
        },
      );
      if (response.data['message'] == 'Successful') {
        print('Ahli berjaya ditambah!');
        return ErrorResponse(true, '');
      }
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);

      return ErrorResponse(
          false,
          e.response!.data['errors']
              .toString()
              .replaceAll(new RegExp(r"\p{P}", unicode: true), ""));
    } on Error catch (e) {
      return ErrorResponse(false, e.stackTrace.toString());
    }
    return ErrorResponse(false, 'Unknown API error');
  }
}

var api = Api();
