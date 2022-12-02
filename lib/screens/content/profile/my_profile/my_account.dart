import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/country.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class MyAccountScreen extends StatefulWidget {
  MyAccountScreen({Key? key}) : super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  // ignore: unused_field
  String _radioVal = '';

  TextEditingController dateinput = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  String firstName = state.user.firstName!;
  String lastName = state.user.lastName!;

  String email = state.user.email!;
  int citizenship = state.user.citizenship!;
  String address1 = state.user.address1!;
  String? address2 = state.user.address2;
  String? address3 = state.user.address3;
  int? countryID = state.user.countryId!;
  int? stateID = state.user.stateId;
  int? districtID = state.user.districtId;
  int? cityID = state.user.cityId;
  String postcode = state.user.postcode!;
  String identityNo = state.user.identityNo!;
  int? identityTypeID = state.user.getIdentityType!.id;
  String? stateName = state.user.stateName;
  String? districtName = state.user.districtName;
  String? cityName = state.user.cityName;
  int? countryNationalityId = state.user.countryNationalityId;

  bool isChecked = false;
  bool _isLoading = false;

  bool _isReadOnly = false;
  bool _isDisable = true;
  bool _isFilled = true;
  bool _isCanUpdated = true;
  bool _isCanStored = false;
  bool _isVisibleBtnSubmit = false;

  bool _isVisibleEndDate = false;
  String identityEndDate = '';

  bool _isMalaysia = true;
  bool _isNotMalaysia = false;

  final _formKey = GlobalKey<FormState>();

  List<Country> _countryModel = [];
  List<States> _statesModel = [];
  List<District> _districtModel = [];
  List<City> _cityModel = [];
  // bool _isPostCodeEmpty = true;

  bool _isPostcodeNotMalaysia = true;
  bool _isPassport = false;

  List<IdentityType> _identityTypeCitizenModel = [];
  List<IdentityType> _identityTypeNonCitezenModel = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    phoneNo.text = state.user.phoneNo!;
    if (state.user.passport != null) {
      dateinput.text = state.user.passport!.passportEndDate.toString();
    }
    _getData();
    print(citizenship);
    onChangedPostcode(postcode);
    onChangedEmail(email);

    if (citizenship == 1) {
      _isMalaysia = true;
      _isNotMalaysia = false;
      _isPostcodeNotMalaysia = false;

    } else {
      _isMalaysia = false;
      _isNotMalaysia = true;
      _isPostcodeNotMalaysia = true;
    }

    if (identityTypeID == 2) {
      // Passport
      _isVisibleEndDate = true;
      _isPassport = true;
    } else if (identityTypeID == 4) {
      //MyKAS
      _isVisibleEndDate = true;
      _isPassport = false;
    } else {
      //kad pengenalan , my tentetra, my pr
      _isVisibleEndDate = false;
      _isPassport = false;
    }
  }

  void _getData() async {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => showLoadingBar(context));
    _countryModel = await api.getCountry();
    _statesModel = await api.getStates();
    _districtModel = await api.getDistrict(stateID);
    _cityModel = await api.getCity();
    _identityTypeCitizenModel = await api.getIndentityType();
    _identityTypeNonCitezenModel = await api.getIndentityTypeNonCitezen();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  bool _isEmailValid = false;
  bool _isPostCodeValid = false;

  // RegexExp
  final emailRE = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneRE = RegExp(r"^(\+?6?01)[0-46-9]-*[0-9]{7,8}$");
  final nameRE = RegExp(r"^(?=.{3})[a-zA-Z0-9_\-=@/',\.;\s]+$");
  final postcodeRE = RegExp(r"^\b\d{5}\b$");

  // Email
  onChangedEmail(String emailPattern) {
    setState(
      () {
        _isEmailValid = false;
        if (emailRE.hasMatch(emailPattern)) _isEmailValid = true;
      },
    );
  }

  // PostCode
  onChangedPostcode(String postCodePattern) {
    setState(
      () {
        _isPostCodeValid = false;
        if (postcodeRE.hasMatch(postCodePattern)) _isPostCodeValid = true;
      },
    );
  }

  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];

  // Group postcode api
  void _getDataPostcodeCityState() async {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => showLoadingBar(context));
    _getDataPostcodeState();
    _getDataPostcodeCity();
    _getDataStateCity();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  void _getDataDistrict() async {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => showLoadingBar(context));
    _districtModel = await api.getDistrict(stateID!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

  // State
  void _getDataStateCity() async {
    // _stateModel = await api.getStates();
    _cityModel = await api.getCity();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          // _postcodeStateModel.map((item) {
          //   stateID = item.id;
          // }).toList();

          _postcodeCityModel.map((item) {
            cityID = item.id;
          }).toList();
        }));
  }

  void _getDataPostcodeState() async {
    _postcodeStateModel = await api.getPostcodeState(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeStateModel.map((item) {
            stateID = item.id;
            _getDataDistrict();
          }).toList();
        }));
  }

  void _getDataPostcodeCity() async {
    _postcodeCityModel = await api.getPostcodeCity(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeCityModel.map((item) {
            cityID = item.id;
          }).toList();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Kemaskini Profil',
          style: styles.heading1sub,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 20, 10),
            child: Column(
              children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        _isReadOnly = !_isReadOnly;
                        _isDisable = !_isDisable;
                        _isFilled = !_isFilled;
                        _isCanStored = !_isCanStored;
                        _isCanUpdated = !_isCanUpdated;
                        _isVisibleBtnSubmit = !_isVisibleBtnSubmit;
                      });
                    },
                    child: _isCanUpdated ? Text("Kemaskini") : Text("Batal")),
              ],
            ),
          ),
        ],
      ), //AppB
      body: Container(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: _isReadOnly,
                      textInputAction: TextInputAction.next,
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('E-mel'),
                        filled: _isFilled,
                        suffixIcon: _isEmailValid
                            ? IconTheme(
                                data: IconThemeData(color: Colors.green),
                                child: Icon(
                                  LineIcons.checkCircle,
                                ))
                            : IconTheme(
                                data: IconThemeData(color: Colors.red),
                                child: Icon(
                                  LineIcons.timesCircle,
                                )),
                      ),
                      initialValue: email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan e-mel';
                        }
                        if (!emailRE.hasMatch(value)) {
                          return 'Sila masukkan e-mel yang sah';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        onChangedEmail(email);
                        email = email;
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: _isReadOnly,
                      textInputAction: TextInputAction.next,
                      keyboardType: _isMalaysia ? TextInputType.number : null,
                      decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel('Nombor Telefon'),
                          hintText:
                              _isMalaysia ? '01123456789' : '+601123456789',
                          filled: _isFilled),
                      controller: phoneNo,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan nombor telefon';
                        }
                        if (!phoneRE.hasMatch(value)) {
                          return 'Sila masukkan nombor telefon yang sah';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          val = phoneNo.text;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: _isReadOnly,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel('Nama Pertama'),
                          filled: _isFilled),
                      initialValue: firstName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan nama pertama';
                        }
                        if (!nameRE.hasMatch(value)) {
                          return 'Sila masukkan nama pertaman yang sah';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          firstName = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: _isReadOnly,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel('Nama Akhir'),
                          filled: _isFilled),
                      initialValue: lastName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan nama akhir';
                        }
                        if (!nameRE.hasMatch(value)) {
                          return 'Sila masukkan nama akhir yang sah';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          lastName = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IgnorePointer(
                          ignoring: _isDisable,
                          child: Radio(
                            value: 1,
                            groupValue: citizenship,
                            activeColor: Colors.blue,
                            onChanged: (value) {
                              setState(() {
                                citizenship = value as int;
                                _radioVal = 'Warganegara';
                                _isMalaysia = true;
                                _isNotMalaysia = false;
                                countryID = 458;
                                // _isPostcodeNotMalaysia = false;
                                // _isCountryIdMalaysia = false;
                                _isPostcodeNotMalaysia = false;
                                identityTypeID = null;
                                phoneNo.clear();
                              });
                            },
                          ),
                        ),
                        Text('Warganegara',
                            style: _isReadOnly
                                ? styles.heading18grey
                                : styles.heading18),
                        IgnorePointer(
                          ignoring: _isDisable,
                          child: Radio(
                            value: 0,
                            groupValue: citizenship,
                            activeColor: Colors.pink,
                            onChanged: (value) {
                              setState(() {
                                citizenship = value as int;
                                _radioVal = 'Bukan Warganegara';
                                // _isCountryIdMalaysia = false;
                                // _isPostcodeNotMalaysia = true;
                                _isPostcodeNotMalaysia = true;
                                _isMalaysia = false;
                                _isNotMalaysia = true;
                                countryID = state.user.countryId;
                                postcode = '';
                                stateID = null;
                                districtID = null;
                                cityID = null;
                                identityTypeID = null;
                                phoneNo.clear();
                              });
                            },
                          ),
                        ),
                        Text('Bukan Warganegara',
                            style: _isReadOnly
                                ? styles.heading18grey
                                : styles.heading18),
                      ],
                    ),
                      Visibility(
                      visible: _isNotMalaysia,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          IgnorePointer(
                            ignoring: _isDisable,
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: styles.inputDecoration.copyWith(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: _isDisable
                                        ? BorderSide(
                                            color: constants.secondaryColor)
                                        : BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: getRequiredLabel('Kewarganegaraan'),
                                  filled: _isFilled),
                              hint: Text('Sila Pilih'),
                              items: _countryModel.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item.name!),
                                  value: item.id,
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Sila pilih kewarganegaraan pengguna';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  countryNationalityId = val as int?;
                                  print(val);
                                });
                              },
                              value: countryNationalityId,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    IgnorePointer(
                      ignoring: _isDisable,
                      child: DropdownButtonFormField(
                        value: identityTypeID,
                        isExpanded: true,
                        decoration: styles.inputDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide: _isDisable
                                  ? BorderSide(color: constants.secondaryColor)
                                  : BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: getRequiredLabel('Jenis Identiti Pengguna'),
                            filled: _isFilled),
                        hint: Text('Sila Pilih'),
                        items: _isMalaysia
                            ? _identityTypeCitizenModel.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item.type!),
                                  value: item.id,
                                );
                              }).toList()
                            : _identityTypeNonCitezenModel.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item.type!),
                                  value: item.id,
                                );
                              }).toList(),
                        onChanged: (val) {
                          setState(() {
                            print(val);
                            identityTypeID = val as int;
                            if (identityTypeID == 2) {
                              // Passport
                              _isVisibleEndDate = true;
                              _isPassport = true;
                            } else if (identityTypeID == 4) {
                              //MyKAS
                              _isVisibleEndDate = true;
                              _isPassport = false;
                            } else {
                              //kad pengenalan , my tentetra, my pr
                              _isVisibleEndDate = false;
                              _isPassport = false;
                            }
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    // Todo passport & kad pengenalan
                    TextFormField(
                      enabled: _isReadOnly,
                      maxLength: _isPassport ? 20 : 12,
                      textInputAction: TextInputAction.next,
                      keyboardType: _isPassport
                          ? TextInputType.text
                          : TextInputType.number,
                      inputFormatters: _isPassport
                          ? [
                              UpperCaseTextFormatter(),
                              FilteringTextInputFormatter(RegExp(r"[A-Z0-9]+"),
                                  allow: true)
                            ]
                          : [FilteringTextInputFormatter.digitsOnly],
                      decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel('No. Identiti Pengguna'),
                          filled: _isFilled),
                      initialValue: identityNo,
                      validator: _isPassport
                          ? (value) {
                              if (value == null || value.isEmpty) {
                                return 'Sila masukkan no. identiti pengguna';
                              }
                              // else if (!passportRE.hasMatch(value)) {
                              //   return 'Sila masukkan no. identiti pengguna yang sah';
                              // }
                              return null;
                            }
                          : (value) {
                              if (value == null || value.isEmpty) {
                                return 'Sila masukkan no. identiti pengguna';
                              } else if (value.length < 11) {
                                return 'Sila masukkan no. identiti pengguna yang sah';
                              }
                              return null;
                            },
                      onChanged: (val) {
                        setState(() {
                          identityNo = val;
                        });
                      },
                    ),
                    Visibility(
                      visible: _isVisibleEndDate,
                      child: Column(
                        children: [
                          SizedBox(height: 7),
                          TextFormField(
                            enabled: _isReadOnly,
                            controller: dateinput,
                            decoration: styles.inputDecoration.copyWith(
                                suffix: Icon(LineIcons.calendarAlt),
                                label:
                                    getRequiredLabel('Tarikh Tamat Passport'),
                                filled: _isFilled),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                // print(pickedDate);
                                String formattedDate =
                                    dateFormatter.format(pickedDate);
                                // print(formattedDate);
                                setState(() {
                                  dateinput.text = formattedDate;
                                  identityEndDate = dateinput.text;
                                  // toIso8601String(),
                                  print(formattedDate);
                                });
                              } else {
                                print("Date is not selected");
                              }
                            },
                          ),
                          SizedBox(height: 13),
                        ],
                      ),
                    ),
                    SizedBox(height: 7),
                    TextFormField(
                      enabled: _isReadOnly,
                      textInputAction: TextInputAction.next,
                      decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel('Alamat 1'),
                          filled: _isFilled),
                      initialValue: address1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Sila masukkan alamat 1';
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          address1 = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: _isReadOnly,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: styles.inputDecoration
                          .copyWith(labelText: 'Alamat 2', filled: _isFilled),
                      initialValue: address2,
                      onChanged: (val) {
                        setState(() {
                          address2 = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      enabled: _isReadOnly,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      decoration: styles.inputDecoration
                          .copyWith(labelText: 'Alamat 3', filled: _isFilled),
                      initialValue: address3,
                      onChanged: (val) {
                        setState(() {
                          address3 = val;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: IgnorePointer(
                            ignoring: _isDisable,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                decoration: styles.inputDecoration.copyWith(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: _isDisable
                                        ? BorderSide(
                                            color: constants.secondaryColor)
                                        : BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: getRequiredLabel('Negara'),
                                  filled: _isFilled,
                                ),
                                items: _countryModel.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.name!,
                                        overflow: TextOverflow.ellipsis),
                                    value: item.id,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Sila pilih negara';
                                  }
                                  return null;
                                },
                                // todo if select malaysia poskod change
                                onChanged: (val) {
                                  setState(() {
                                    stateID = null;
                                    districtID = null;
                                    countryID = val as int;
                                  });
                                },
                                value: countryID,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Visibility(
                          visible: !_isPostcodeNotMalaysia,
                            child: Expanded(
                              flex: 5,
                              child: TextFormField(
                                enabled: _isReadOnly,
                                maxLength: 5,
                                initialValue: postcode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                  decoration: styles.inputDecoration.copyWith(
                                  label: getRequiredLabel('Poskod'),
                                  filled: _isFilled,
                                  suffixIcon: _isPostCodeValid
                                      ? IconTheme(
                                          data:
                                              IconThemeData(color: Colors.green),
                                          child: Icon(
                                            LineIcons.checkCircle,
                                          ))
                                      : IconTheme(
                                          data: IconThemeData(color: Colors.red),
                                          child: Icon(
                                            LineIcons.timesCircle,
                                          ),
                                        ),
                                        ),
                                    validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Sila masukkan poskod';
                                  } else if (!postcodeRE.hasMatch(value)) {
                                      return 'Poskod mestilah 5 digit';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    print(postcode);
                                    postcode = val;
                                    onChangedPostcode(postcode.toString());
                                    postcode = postcode;
                                    if (postcode.length >= 5) {
                                      _getDataPostcodeCityState();
                                    } else {
                                      stateID = null;
                                      cityID = null;
                                      districtID = null;
                                    }
                                  });
                                },
                              ),
                          ),
                        ),
                        // Postcode not malaysia
                        Visibility(
                          visible: _isPostcodeNotMalaysia,
                          child: Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                enabled: _isReadOnly,
                                initialValue: postcode,
                                textInputAction: TextInputAction.next,
                                decoration: styles.inputDecoration.copyWith(
                                  label: getRequiredLabel('Poskod'),
                                  filled: _isFilled
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Sila masukkan poskod';
                                  } else if (value.length < 4) {
                                    return 'Poskod tidak sah';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    print(postcode);
                                    postcode = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 7),
                    Row(
                      children: [
                        Visibility(
                          visible: _isMalaysia,
                          child: Expanded(
                            flex: 5,
                            child: IgnorePointer(
                              ignoring: _isDisable,
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                decoration: styles.inputDecoration.copyWith(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: _isDisable
                                          ? BorderSide(
                                              color: constants.secondaryColor)
                                          : BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    label: getRequiredLabel('Negeri'),
                                    filled: _isFilled),
                                hint: Text('Pilih Negeri',
                                    overflow: TextOverflow.ellipsis),
                                items: _statesModel.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.name!),
                                    value: item.id,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Sila pilih negeri';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    stateID = val as int;
                                  });
                                },
                                value: stateID,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _isNotMalaysia,
                          child: Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                enabled: _isReadOnly,
                                textInputAction: TextInputAction.next,
                                decoration: styles.inputDecoration.copyWith(
                                    label: getRequiredLabel('Nama Negeri'),
                                    hintText: 'Sila masukkan nama negeri.',
                                    filled: _isFilled),
                                initialValue: stateName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Sila masukkan nama negeri';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    stateName = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Visibility(
                          visible: _isMalaysia,
                          child: Expanded(
                            flex: 5,
                            child: IgnorePointer(
                              ignoring: _isDisable,
                              child: DropdownButtonFormField(
                                isExpanded: true,
                                decoration: styles.inputDecoration.copyWith(
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: _isDisable
                                          ? BorderSide(
                                              color: constants.secondaryColor)
                                          : BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    label: getRequiredLabel('Daerah'),
                                    filled: _isFilled),
                                hint: Text('Pilih Daerah'),
                                items: _districtModel.map((item) {
                                  return new DropdownMenuItem(
                                    child: new Text(item.name!,
                                        overflow: TextOverflow.ellipsis),
                                    value: item.id,
                                  );
                                }).toList(),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Sila pilih daerah';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    districtID = val as int;
                                  });
                                },
                                value: districtID,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: _isNotMalaysia,
                          child: Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                enabled: _isReadOnly,
                                textInputAction: TextInputAction.next,
                                decoration: styles.inputDecoration.copyWith(
                                    label: getRequiredLabel('Nama Daerah'),
                                    hintText: 'Sila masukkan nama daerah.',
                                    filled: _isFilled),
                                initialValue: districtName,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Sila masukkan nama daerah';
                                  }
                                  return null;
                                },
                                onChanged: (val) {
                                  setState(() {
                                    districtName = val;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: _isMalaysia,
                      child: IgnorePointer(
                        ignoring: _isDisable,
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            DropdownButtonFormField(
                              isExpanded: true,
                              decoration: styles.inputDecoration.copyWith(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: _isDisable
                                        ? BorderSide(
                                            color: constants.secondaryColor)
                                        : BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  label: getRequiredLabel('Bandar'),
                                  filled: _isFilled),
                              hint: Text('Pilih Bandar'),
                              items: _cityModel.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item.name!),
                                  value: item.id,
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Sila pilih bandar';
                                }
                                return null;
                              },
                              onChanged: (val) {
                                setState(() {
                                  cityID = val as int;
                                });
                              },
                              value: cityID,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: _isNotMalaysia,
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          TextFormField(
                            enabled: _isReadOnly,
                            textInputAction: TextInputAction.next,
                            decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Nama Bandar'),
                                hintText: 'Sila masukkan nama bandar.',
                                filled: _isFilled),
                            initialValue: cityName,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Sila masukkan nama bandar';
                              }
                              return null;
                            },
                            onChanged: (val) {
                              setState(() {
                                cityName = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _isVisibleBtnSubmit,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          _isLoading
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12.0),
                                  child: SpinKitFoldingCube(
                                    color: constants.primaryColor,
                                    size: 20,
                                  ),
                                )
                              : PrimaryButton(
                                  isLoading: _isLoading,
                                  text: 'Kemaskini'.toUpperCase(),
                                  onPressed: _isLoading
                                      ? null
                                      : () async {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            try {
                                              var response =
                                                  await api.updateProfile(
                                                      firstName,
                                                      lastName,
                                                      email,
                                                      phoneNo.text,
                                                      citizenship,
                                                      address1,
                                                      address2,
                                                      address3,
                                                      stateID,
                                                      districtID,
                                                      cityID,
                                                      postcode,
                                                      identityTypeID,
                                                      identityNo);

                                              if (response.isSuccessful) {
                                                setState(() {
                                                  _isLoading = false;
                                                });
                                                snack(context,
                                                    'Profile berjaya dikemaskini',
                                                    level: SnackLevel.Success);
                                                // await Future.delayed(
                                                //     const Duration(
                                                //         milliseconds: 2250));
                                                back(context);
                                                return;
                                              }
                                              hideSnacks(context);
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              snack(context, response.message,
                                                  level: SnackLevel.Error);
                                            } catch (e) {
                                              snack(context,
                                                  "Ralat tidak dapat dikenal pasti!");
                                            }
                                          }
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
