import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/country.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/screens/auth/verify.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController dateinput = TextEditingController();
  TextEditingController phoneNo = TextEditingController();

  // ignore: unused_field
  String _radioVal = '';

  String email = '';
  bool isBanned = true;
  String firstName = '';
  String lastName = '';
  int citizenship = 1; // 1 = Warganegara
  int? countryID = 458;
  int? stateID;
  String address1 = '';
  String address2 = '';
  String address3 = '';
  String postcode = '';
  int? districtID;
  int? cityID;
  bool isCheckedTnc = false;
  String password = '';
  String passwordConfirmation = '';
  int? identityTypeID;
  String identityNo = '';
  String identityEndDate = '';
  String stateName = '';
  String districtName = '';
  String cityName = '';
  int? countryNationalityId;

  bool _isLoading = false;
  bool _isVisiblePass = false;

  List<District> _districtModel = [];
  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];
  List<PostcodeCity> _postcodeCityNameModel = [];
  List<PostcodeState> _postcodeStateNameModel = [];

  List<States> _stateModel = [];
  List<City> _cityModel = [];
  bool _isPostCodeEmpty = true;

  bool _isEmailValid = false;
  bool _isPostCodeValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  List<IdentityType> _identityTypeCitizenModel = [];
  List<IdentityType> _identityTypeNonCitezenModel = [];
  List<Country> _countryModel = [];

  bool _isMalaysia = true;
  bool _isNotMalaysia = false;
  bool _isVisibleEndDate = false;
  bool _isCountryIdMalaysia = false;
  bool _isPostcodeNotMalaysia = false;
  bool _isPassport = false;

  // RegexExp
  final emailRE = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final phoneRE = RegExp(r"^(\+?6?01)[0-46-9]-*[0-9]{7,8}$");
  final nameRE = RegExp(r"^(?=.{3})[a-zA-Z0-9_\-=@/',\.;\s]+$");
  final postcodeRE = RegExp(r"^\b\d{5}\b$");
  final passwordRE = RegExp(
      r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.\/])[A-Za-z\d@$!%*?&.\/]{8,20}$");

  // final passportRE = RegExp(r'^(?!^0+$)[a-zA-Z0-9]{8,20}$');

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

  // Password
  onChangedPassword(String passwordPattern) {
    setState(
      () {
        _isPasswordValid = false;
        if (passwordRE.hasMatch(passwordPattern)) _isPasswordValid = true;
      },
    );
  }

  // Confirm Password
  onChangedConfirmPassword(String confirmPasswordPattern) {
    setState(
      () {
        _isConfirmPasswordValid = false;
        if (password.isEmpty)
          _isConfirmPasswordValid = false;
        else if (password == confirmPasswordPattern)
          _isConfirmPasswordValid = true;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _getData();
    // api.getCity(postcodeId!);
    // if (mounted) {
    //   setState(() {
    //     _getData();
    //   });
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _getData() async {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => showLoadingBar(context));
    _countryModel = await api.getCountry();
    _identityTypeCitizenModel = await api.getIndentityType();
    _identityTypeNonCitezenModel = await api.getIndentityTypeNonCitezen();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
        }));
  }

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

  // Postcode state
  void _getDataPostcodeState() async {
    _postcodeStateModel = await api.getPostcodeState(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeStateModel.map((item) {
            stateID = item.id;
            _getDataDistrict();
          }).toList();
        }));
  }

  // State
  void _getDataStateCity() async {
    _stateModel = await api.getStates();
    _cityModel = await api.getCity();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _postcodeStateModel.map((item) {
            stateID = item.id;
          }).toList();

          _postcodeCityModel.map((item) {
            cityID = item.id;
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
          'Pendaftaran Pengguna',
          style: styles.heading1sub,
        ),
      ),
      body: SafeArea(
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
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('E-mel'),
                      hintText: 'Gunakan e-mel peribadi anda',
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
                      setState(() {
                        email = val;
                        onChangedEmail(email);
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: _isMalaysia ? TextInputType.number : null,
                    // inputFormatters: _isMalaysia
                    //     ? [FilteringTextInputFormatter.digitsOnly]
                    //     : [
                    //         FilteringTextInputFormatter.allow(
                    //             RegExp(r"^(\+?6?01)[0-46-9]-*[0-9]{7,8}$")),
                    //       ],
                    // +60 (123) 456-7890
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Nombor Telefon'),
                      hintText: _isMalaysia ? '01123456789' : '+601123456789',
                    ),
                    controller: phoneNo,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan nombor telefon';
                      } else if (!phoneRE.hasMatch(value)) {
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
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Nama Pertama'),
                      hintText: 'Nama pertama',
                    ),
                    initialValue: firstName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan nama pertama';
                      } else if (!nameRE.hasMatch(value)) {
                        return 'Sila masukkan nama pertama yang sah';
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
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Nama Akhir'),
                      hintText: 'Nama akhir',
                    ),
                    initialValue: lastName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan nama akhir';
                      } else if (!nameRE.hasMatch(value)) {
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
                      Radio(
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
                            _isPostcodeNotMalaysia = false;
                            _isCountryIdMalaysia = false;
                            identityTypeID = null;
                            phoneNo.clear();
                          });
                        },
                      ),
                      Text(
                        'Warganegara',
                        style: styles.heading18,
                      ),
                      Radio(
                        value: 0,
                        groupValue: citizenship,
                        activeColor: Colors.pink,
                        onChanged: (value) {
                          setState(() {
                            citizenship = value as int;
                            _radioVal = 'Bukan Warganegara';
                            _isMalaysia = false;
                            _isNotMalaysia = true;
                            _isCountryIdMalaysia = false;
                            _isPostcodeNotMalaysia = true;
                            countryID = null;
                            postcode = '';
                            stateID = null;
                            districtID = null;
                            cityID = null;
                            identityTypeID = null;
                            phoneNo.clear();
                          });
                        },
                      ),
                      Text(
                        'Bukan Warganegara',
                        style: styles.heading18,
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isNotMalaysia,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        DropdownButtonFormField(
                          isExpanded: true,
                          decoration: styles.inputDecoration.copyWith(
                            label: getRequiredLabel('Kewarganegaraan'),
                          ),
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
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Visibility(
                    visible: true,
                    child: DropdownButtonFormField(
                      isExpanded: true,
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('Jenis Identiti Pengguna'),
                      ),
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
                      validator: (value) {
                        if (value == null) {
                          return 'Sila pilih jenis identiti pengguna';
                        }
                        return null;
                      },
                      //! NEED TO INTEGRATE WITH MSP
                      onChanged: (val) {
                        setState(() {
                          identityTypeID = val as int?;
                          print(val);
                          if (identityTypeID == 2) {
                            _isVisibleEndDate = true;
                            _isPassport = true;
                          } else if (identityTypeID == 4) {
                            _isVisibleEndDate = true;
                            _isPassport = false;
                          } else {
                            _isVisibleEndDate = false;
                            _isPassport = false;
                          }
                        });
                      },
                      value: identityTypeID,
                    ),
                  ),

                  SizedBox(height: 20),
                  TextFormField(
                    maxLength: _isPassport ? 20 : 12,
                    textInputAction: TextInputAction.next,
                    keyboardType:
                        _isPassport ? TextInputType.text : TextInputType.number,
                    inputFormatters: _isPassport
                        ? [
                            UpperCaseTextFormatter(),
                            FilteringTextInputFormatter(RegExp(r"[A-Z0-9]+"),
                                allow: true)
                          ]
                        : [FilteringTextInputFormatter.digitsOnly],
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('No. Identiti Pengguna'),
                    ),
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
                          controller: dateinput,
                          decoration: styles.inputDecoration.copyWith(
                              suffix: Icon(LineIcons.calendarAlt),
                              label: getRequiredLabel(
                                  'Tarikh Tamat No Identiti Pengguna')),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Sila pilih tarikh tamat no identiti pengguna';
                            }
                            return null;
                          },
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              String formattedDate =
                                  dateFormatter.format(pickedDate);
                              setState(() {
                                dateinput.text = formattedDate;
                                identityEndDate = dateinput.text;
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
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Alamat 1'),
                    ),
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
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      labelText: 'Alamat 2',
                    ),
                    initialValue: address2,
                    onChanged: (val) {
                      setState(() {
                        address2 = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      labelText: 'Alamat 3',
                    ),
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
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: DropdownButtonFormField(
                            isExpanded: true,
                            decoration: styles.inputDecoration.copyWith(
                              label: getRequiredLabel('Negara'),
                            ),
                            value: countryID,
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
                            onChanged: (newVal) {
                              setState(() {
                                stateID = null;
                                districtID = null;
                                countryID = newVal as int?;
                                print(countryID);
                                if (countryID == 458) {
                                  print('Negara adalah malaysia');
                                  _isMalaysia = true;
                                  _isCountryIdMalaysia = true;
                                  _isNotMalaysia = false;
                                } else {
                                  print('Negara bukan malaysia');
                                  _isMalaysia = false;
                                  _isCountryIdMalaysia = false;
                                  _isNotMalaysia = true;
                                  _isPostcodeNotMalaysia = true;
                                }
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Postcode is malaysia
                      Visibility(
                        visible: !_isPostcodeNotMalaysia,
                        child: Expanded(
                          flex: 5,
                          child: TextFormField(
                            // maxLength: _isCountryIdMalaysia ? 5 : 20,
                            maxLength: 5,
                            initialValue: postcode,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: styles.inputDecoration.copyWith(
                              label: getRequiredLabel('Poskod'),
                              suffixIcon: _isPostCodeValid
                                  ? IconTheme(
                                      data: IconThemeData(color: Colors.green),
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
                              initialValue: postcode,
                              textInputAction: TextInputAction.next,
                              decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Poskod'),
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
                  // Negeri
                  Row(
                    children: [
                      Visibility(
                        visible: _isMalaysia,
                        child: Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Negeri'),
                                hintText: 'Sila Pilih',
                              ),
                              items: _isPostCodeEmpty
                                  ? _stateModel.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item.name.toString(),
                                            overflow: TextOverflow.ellipsis),
                                        value: item.id,
                                      );
                                    }).toList()
                                  : _postcodeStateModel.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item.name.toString(),
                                            overflow: TextOverflow.ellipsis),
                                        value: item.id,
                                      );
                                    }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Sila pilih negeri';
                                }
                                return null;
                              },
                              onChanged: (newVal) {
                                setState(() {
                                  districtID = null;
                                  stateID = newVal as int?;
                                  print(stateID);
                                  _getDataDistrict();
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
                              textInputAction: TextInputAction.next,
                              decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Nama Negeri'),
                                hintText: 'Sila masukkan nama negeri.',
                              ),
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
                      Visibility(
                        visible: _isCountryIdMalaysia,
                        child: Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Nama Negeri'),
                                hintText: 'Sila Pilih',
                              ),
                              items: _postcodeStateNameModel.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item.name.toString(),
                                      overflow: TextOverflow.ellipsis),
                                  value: item.id,
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Sila pilih negeri';
                                }
                                return null;
                              },
                              onChanged: (newVal) {
                                setState(() {
                                  stateName = newVal as String;
                                  print(stateID);
                                });
                              },
                              value: stateName,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      // Daerah
                      Visibility(
                        visible: _isMalaysia,
                        child: Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButtonFormField(
                              value: districtID,
                              isExpanded: true,
                              decoration: styles.inputDecoration.copyWith(
                                  label: getRequiredLabel('Daerah'),
                                  hintText: 'Sila Pilih'),
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
                              onChanged: (newVal) {
                                setState(() {
                                  districtID = newVal as int;
                                });
                              },
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
                              textInputAction: TextInputAction.next,
                              decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Nama Daerah'),
                                hintText: 'Sila masukkan nama daerah.',
                              ),
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
                      Visibility(
                        visible: _isCountryIdMalaysia,
                        child: Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: DropdownButtonFormField(
                              isExpanded: true,
                              decoration: styles.inputDecoration.copyWith(
                                label: getRequiredLabel('Nama Daerah'),
                                hintText: 'Sila Pilih',
                              ),
                              items: _postcodeStateNameModel.map((item) {
                                return new DropdownMenuItem(
                                  child: new Text(item.name.toString(),
                                      overflow: TextOverflow.ellipsis),
                                  value: item.id,
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null) {
                                  return 'Sila pilih negeri';
                                }
                                return null;
                              },
                              onChanged: (newVal) {
                                setState(() {
                                  districtName = newVal as String;
                                  print(districtName);
                                });
                              },
                              value: districtName,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  // Bandar
                  Visibility(
                    visible: _isMalaysia,
                    child: DropdownButtonFormField(
                      value: cityID,
                      isExpanded: true,
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('Bandar'),
                        hintText: 'Sila Pilih',
                      ),
                      items: _isPostCodeEmpty
                          ? _cityModel.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name.toString(),
                                    overflow: TextOverflow.ellipsis),
                                value: item.id,
                              );
                            }).toList()
                          : _postcodeCityModel.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name.toString(),
                                    overflow: TextOverflow.ellipsis),
                                value: item.id,
                              );
                            }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Sila pilih bandar';
                        }
                        return null;
                      },
                      onChanged: (newVal) {
                        setState(() {
                          cityID = newVal as int;
                        });
                      },
                    ),
                  ),
                  Visibility(
                    visible: _isNotMalaysia,
                    child: TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('Nama Bandar'),
                        hintText: 'Sila masukkan nama bandar.',
                      ),
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
                  ),
                  Visibility(
                    visible: _isCountryIdMalaysia,
                    child: DropdownButtonFormField(
                      value: cityName,
                      isExpanded: true,
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('Nama Bandar'),
                        hintText: 'Sila Pilih',
                      ),
                      // items: _isPostCodeEmpty
                      // ? _postcodeCityNameModel.map((item) {
                      //     return new DropdownMenuItem(
                      //       child: new Text(item.name.toString(),
                      //           overflow: TextOverflow.ellipsis),
                      //       value: item.id,
                      //     );
                      //   }).toList()
                      // : _cityModel.map((item) {
                      //     return new DropdownMenuItem(
                      //       child: new Text(item.name.toString(),
                      //           overflow: TextOverflow.ellipsis),
                      //       value: item.id,
                      //     );
                      //   }).toList(),
                      items: _isPostCodeEmpty
                          ? _postcodeCityNameModel.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name.toString(),
                                    overflow: TextOverflow.ellipsis),
                                value: item.id,
                              );
                            }).toList()
                          : _cityModel.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name.toString(),
                                    overflow: TextOverflow.ellipsis),
                                value: item.id,
                              );
                            }).toList(),

                      validator: (value) {
                        if (value == null) {
                          return 'Sila pilih bandar';
                        }
                        return null;
                      },
                      onChanged: (newVal) {
                        setState(() {
                          cityName = newVal as String;
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  // Kata Laluan
                  TextFormField(
                    obscureText: !_isVisiblePass,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Kata Laluan'),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isPasswordValid
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
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisiblePass = !_isVisiblePass;
                              });
                            },
                            icon: _isVisiblePass
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    initialValue: password,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan kata laluan';
                      }
                      if (!passwordRE.hasMatch(value)) {
                        return 'Sila masukkan kata laluan yang sah';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        password = val;
                        onChangedPassword(password);
                        password = password;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: !_isVisiblePass,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Pengesahan Kata Laluan'),
                      suffixIcon: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isConfirmPasswordValid
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
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isVisiblePass = !_isVisiblePass;
                              });
                            },
                            icon: _isVisiblePass
                                ? Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                          ),
                        ],
                      ),
                    ),
                    initialValue: passwordConfirmation,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return 'Sila masukkan pengesahan kata laluan';
                        } else if (value != password) {
                          return 'Pengesahan kata laluan mestilah sama';
                        }
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        passwordConfirmation = val;
                        onChangedConfirmPassword(passwordConfirmation);
                        passwordConfirmation = passwordConfirmation;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        value: isCheckedTnc,
                        onChanged: (
                          bool? value,
                        ) {
                          setState(() {
                            isCheckedTnc = value!;
                          });
                        },
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            showLoadingBar(context);
                            // showAlertDialog(context);
                            //  launchUrl(Uri.parse('https://public.ipayment.phgo.xyz/tnc'));
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'Dengan mendaftar, anda bersetuju dengan ',
                              style: styles.heading2,
                              children: [
                                TextSpan(
                                  text: 'Terma & Syarat',
                                  style: styles.heading6bold,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  _isLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: SpinKitFoldingCube(
                            color: constants.primaryColor,
                            size: 20,
                          ),
                        )
                      : PrimaryButton(
                          isLoading: _isLoading,
                          text: 'Daftar'.toUpperCase(),
                          onPressed: !isCheckedTnc
                              ? null
                              : () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    try {
                                      var response = await api.register(
                                          email,
                                          isBanned,
                                          firstName,
                                          lastName,
                                          citizenship,
                                          identityNo,
                                          countryID!,
                                          stateID,
                                          address1,
                                          address2,
                                          address3,
                                          postcode,
                                          districtID,
                                          cityID,
                                          phoneNo.text,
                                          isCheckedTnc,
                                          password,
                                          passwordConfirmation,
                                          identityTypeID!,
                                          identityEndDate,
                                          stateName,
                                          districtName,
                                          cityName,
                                          countryNationalityId);
                                      if (response.isSuccessful) {
                                        var verifyRoute = MaterialPageRoute(
                                            builder: (_) => VerifyEmailPage());
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        await store.setItem(
                                            'getEmailWidget', email);

                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                verifyRoute, (route) => false);
                                        hideSnacks(context);
                                        snack(
                                            context,
                                            "Pendaftaran anda telah berjaya dihantar. Sila rujuk e-mel " +
                                                email +
                                                " untuk mengaktifkan profil anda.",
                                            level: SnackLevel.Success);
                                        return;
                                      }
                                      hideSnacks(context);
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      snack(context, response.message,
                                          level: SnackLevel.Error);
                                    } catch (e) {
                                      snack(
                                          context, "Ralat tidak dikenalpasti.");
                                    }
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }),
                  SizedBox(height: 23),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sudah mempunyai akaun? ",
                            style: styles.heading2,
                          ),
                          SizedBox(width: 5),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(
                                context,
                              );
                            },
                            child:
                                Text("Log Masuk", style: styles.heading6bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Terms & condition
showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    title: Center(child: Text("Terma & Syarat")),
    content: Text(
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet….",
      textAlign: TextAlign.justify,
    ),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
