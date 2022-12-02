import 'package:flutter/scheduler.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/organizations/organization_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/screens/content/profile/my_profile/profile.dart';

import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

enum SingingCharacter { citizenship, nonCitizenship }

class AddOrganizationScreen extends StatefulWidget {
  AddOrganizationScreen({Key? key}) : super(key: key);

  @override
  _AddOrganizationScreenState createState() => _AddOrganizationScreenState();
}

class _AddOrganizationScreenState extends State<AddOrganizationScreen> {
  TextEditingController dateinput = TextEditingController();

  int userId = state.user.id!;
  String orgName = '';
  String orgEmail = '';
  int? orgTypeId;
  String orgRegistrationNo = '';
  String orgRegistrationNoOld = '';
  String dateExtablished = '';
  String address1 = '';
  String address2 = '';
  String address3 = '';
  String postcode = '';
  String phoneNo = '';
  int? countryID = 458;
  int? stateID;
  int? districtID;
  int? cityID;

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool isChecked = false;

  // ignore: unused_field
  List<States> _statesModel = [];
  List<District> _districtModel = [];
  // ignore: unused_field
  List<City> _cityModel = [];
  List<OrganizationType> _orgTypeModel = [];

  bool _isEmailValid = false;
  bool _isPostCodeValid = false;

  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];

  bool _isCheckOldSSM = false;

  bool _isShowCheckOldSSM = false;
  bool _isShowOldSSM = false;
  bool _isShowSSM = false;
  bool _isShowROS = false;
  bool _isShowSKM = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  // Email
  onChangedEmail(String emailPattern) {
    final emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    setState(
      () {
        _isEmailValid = false;
        if (emailValid.hasMatch(emailPattern)) _isEmailValid = true;
      },
    );
  }

  onChangedPostcode(String postCodePattern) {
    //r"[pattern here]"
    // pattern = ^[abc]$
    final postCodeValid = RegExp(r"^\b\d{5}\b$");

    setState(
      () {
        _isPostCodeValid = false;
        if (postCodeValid.hasMatch(postCodePattern)) _isPostCodeValid = true;
      },
    );
  }

  void _getData() async {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => showLoadingBar(context));
    _orgTypeModel = await api.getOrganizationType();
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

  // Group postcode api
  void _getDataPostcodeCityState() async {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => showLoadingBar(context));
    _getDataPostcodeState();
    _getDataPostcodeCity();

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          Navigator.pop(context);
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
          'Daftar Organisasi',
          style: styles.heading4,
        ),
      ), //AppBar
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Nama Organisasi'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan orgName';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        orgName = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('E-mel Organisasi'),
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
                    initialValue: orgEmail,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan orgEmail';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        orgEmail = val;
                        onChangedEmail(orgEmail);
                        orgEmail = orgEmail;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    isExpanded: true,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Jenis Organisasi'),
                    ),
                    hint: Text('Sila Pilih'),
                    items: _orgTypeModel.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(item.type!),
                        value: item.id,
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null) {
                        return 'Sila pilih jenis organisasi';
                      }
                      return null;
                    },
                    onChanged: (newVal) {
                      setState(() {
                        orgTypeId = newVal as int;
                        print(orgTypeId);
                        if (orgTypeId == 6) {
                          //show SSM & LAMA
                          _isShowCheckOldSSM = true;
                          _isShowSSM = true;
                          _isShowROS = false;
                          _isShowSKM = false;
                        } else if (orgTypeId == 7) {
                          //show ROS
                          _isShowCheckOldSSM = false;
                          _isShowOldSSM = false;
                          _isShowSSM = false;
                          _isShowROS = true;
                          _isShowSKM = false;
                        } else if (orgTypeId == 8) {
                          //show SKM
                          _isShowOldSSM = false;
                          _isShowCheckOldSSM = false;
                          _isShowSSM = false;
                          _isShowROS = false;
                          _isShowSKM = true;
                        }
                      });
                    },
                    value: orgTypeId,
                  ),
                  SizedBox(height: 13),
                  Visibility(
                    visible: _isShowCheckOldSSM,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          value: _isCheckOldSSM,
                          onChanged: (
                            bool? value,
                          ) {
                            setState(() {
                              if (_isCheckOldSSM = value!) {
                                _isShowSSM = false;
                                _isShowOldSSM = true;
                              } else {
                                _isShowSSM = true;
                                _isShowOldSSM = false;
                              }
                            });
                          },
                        ),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'SSM lama',
                            style: styles.heading6bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 7),
                  // OLD SSM
                  Visibility(
                    visible: _isShowOldSSM,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: TextFormField(
                        maxLength: 9,
                        textInputAction: TextInputAction.next,
                        decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel(
                            'Nombor Pendaftaran SSM Lama ',
                          ),
                          hintText: '1234567-X',
                        ),
                        initialValue: orgRegistrationNo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sila masukkan nombor pendaftaran SSM lama';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            orgRegistrationNo = val;
                          });
                        },
                      ),
                    ),
                  ),
                  // SSM
                  Visibility(
                    visible: _isShowSSM,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: TextFormField(
                        maxLength: 12,
                        textInputAction: TextInputAction.next,
                        decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel(
                            'Nombor Pendaftaran SSM ',
                          ),
                          hintText: '123456789012',
                        ),
                        initialValue: orgRegistrationNo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sila masukkan nombor pendaftaran SSM';
                          } else if (value.length < 12) {
                            return 'Sila masukkan 12 digit';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            orgRegistrationNo = val;
                          });
                        },
                      ),
                    ),
                  ),
                  // ROS
                  Visibility(
                    visible: _isShowROS,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: TextFormField(
                        maxLength: 19,
                        textInputAction: TextInputAction.next,
                        decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel(
                            'Nombor Pendaftaran ROS ',
                          ),
                          hintText: 'ABC-123-45-67890123',
                        ),
                        initialValue: orgRegistrationNo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sila masukkan nombor pendaftaran ROS';
                          } else if (value.length < 19) {
                            return 'Sila masukkan 19 digit';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            orgRegistrationNo = val;
                          });
                        },
                      ),
                    ),
                  ),
                  // SKM
                  Visibility(
                    visible: _isShowSKM,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 7),
                      child: TextFormField(
                        maxLength: 8,
                        textInputAction: TextInputAction.next,
                        decoration: styles.inputDecoration.copyWith(
                          label: getRequiredLabel(
                            'Nombor Pendaftaran SKM',
                          ),
                          hintText: 'A-1-2345',
                        ),
                        initialValue: orgRegistrationNo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Sila masukkan no pendaftaran SKM';
                          } else if (value.length < 8) {
                            return 'Sila masukkan 8 digit';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            orgRegistrationNo = val;
                          });
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                    controller: dateinput,
                    decoration: styles.inputDecoration.copyWith(
                        suffix: Icon(LineIcons.calendarAlt),
                        label: getRequiredLabel('Tarikh Ditubuhkan')),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now());

                      if (pickedDate != null) {
                        String formattedDate = dateFormatter.format(pickedDate);
                        setState(() {
                          dateinput.text = formattedDate;
                          dateExtablished = dateinput.text;
                        });
                      } else {
                        print("Date is not selected");
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('No Telefon'),
                      hintText: '01123456789',
                    ),
                    initialValue: phoneNo.toString(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Sila masukkan Nombor Telefon';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() {
                        phoneNo = val;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Alamat 1'),
                    ),
                    initialValue: address1,
                    validator: (value) {
                      if (value == null) {
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
                        child: TextFormField(
                          maxLength: 5,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
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
                          initialValue: postcode,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length <= 4) {
                              return 'Poskod tidak sah';
                            } else if (value.length < 5) {
                              return 'Poskod mestilah 5 digit';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              postcode = val;
                              onChangedPostcode(postcode);
                              postcode = postcode;
                              districtID = null;
                              cityID = null;
                              stateID = null;
                              if (postcode.length >= 5) {
                                _getDataPostcodeCityState();
                              } else {
                                stateID = null;
                                cityID = null;
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: DropdownButtonFormField(
                            value: stateID,
                            isExpanded: true,
                            decoration: styles.inputDecoration.copyWith(
                              label: getRequiredLabel('Negeri'),
                              hintText: 'Sila Pilih',
                            ),
                            items: _postcodeStateModel.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name!,
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
                                cityID = null;
                                stateID = newVal as int?;
                                print(stateID);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 22),
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
                      SizedBox(width: 10),
                      Expanded(
                        flex: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: DropdownButtonFormField(
                            value: cityID,
                            isExpanded: true,
                            decoration: styles.inputDecoration.copyWith(
                              label: getRequiredLabel('Bandar'),
                              hintText: 'Sila Pilih',
                            ),
                            items: _postcodeCityModel.map((item) {
                              return new DropdownMenuItem(
                                child: new Text(item.name!,
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
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Column(
                      children: [
                        _isLoading
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: SpinKitFoldingCube(
                                  color: constants.primaryColor,
                                  size: 20,
                                ),
                              )
                            : PrimaryButton(
                                isLoading: _isLoading,
                                text: 'Simpan'.toUpperCase(),
                                onPressed: _isLoading
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
                                            var response =
                                                await api.organizationDetail(
                                              userId,
                                              orgName,
                                              orgEmail,
                                              orgTypeId!,
                                              orgRegistrationNo,
                                              dateExtablished,
                                              address1,
                                              address2,
                                              address3,
                                              postcode,
                                              stateID!,
                                              districtID!,
                                              cityID!,
                                              phoneNo,
                                            );
                                            if (response.isSuccessful) {
                                              var homeRoute = MaterialPageRoute(
                                                  builder: (_) =>
                                                      ProfileScreen());
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(homeRoute,
                                                      (route) => false);
                                              hideSnacks(context);
                                              snack(context,
                                                  "Pendaftaran organisasi berjaya.",
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
                                            snack(context,
                                                "Ralat yang tidak dikenalpasti.");
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
    );
  }
}
