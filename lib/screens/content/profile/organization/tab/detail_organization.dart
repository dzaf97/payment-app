import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/models/users/city.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/models/organizations/organization_type.dart';
import 'package:flutterbase/models/users/postcode_city.dart';
import 'package:flutterbase/models/users/postcode_state.dart';
import 'package:flutterbase/models/users/states.dart';
import 'package:flutterbase/models/users/district.dart';
import 'package:flutterbase/screens/onboarding/splash.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

enum SingingCharacter { citizenship, nonCitizenship }

class DetailOrganizationScreen extends StatefulWidget {
  final Organization organization;
  const DetailOrganizationScreen(this.organization, {Key? key});
  @override
  _DetailOrganizationScreenState createState() =>
      _DetailOrganizationScreenState();
}

class _DetailOrganizationScreenState extends State<DetailOrganizationScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getData();
    _getOrganization();
    if (orgTypeId == 6) {
      print('Show SSM');
      _isShowCheckOldSSM = false;
      _isShowSSM = true;
    } else if (orgTypeId == 7) {
      print('Show ROS');
      _isShowROS = true;
    } else {
      print('Show SKM');
      _isShowSKM = true;
    }
    onChangedPostcode(postcode);
    onChangedEmail(orgEmail);
    // If admin give access > edit & deleted
    if (userId == state.user.id) {
      _isAdmin = true;
    } else {
      _isAdmin = false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  List<States> _statesModel = [];
  List<District> _districtModel = [];
  List<City> _cityModel = [];
  List<OrganizationType> _orgTypeModel = [];
  // ignore_for_file: unused_field
  List<PostcodeCity> _postcodeCityModel = [];
  List<PostcodeState> _postcodeStateModel = [];

  int? orgId;
  String orgName = '';
  String orgEmail = '';
  int? orgTypeId;
  String orgRegistrationNo = '';
  String dateExtablished = '';
  String address1 = '';
  String address2 = '';
  String address3 = '';
  String postcode = '';
  String phoneNo = '';
  int? countryId = 458;
  int? stateId;
  int? districtId;
  int? cityId;
  int? userId;

  bool isChecked = false;
  bool _isLoading = false;
  bool _isReadOnly = false;
  bool _isDisable = true;
  bool _isFilled = true;
  bool _isCanUpdated = true;
  bool _isCanStored = false;
  bool _isVisibleBtnSubmit = false;
  bool _isEmailValid = false;
  bool _isPostCodeValid = false;
  bool _isCheckOldSSM = false;
  bool _isShowCheckOldSSM = false;
  bool _isShowOldSSM = false;
  bool _isShowSSM = false;
  bool _isShowROS = false;
  bool _isShowSKM = false;
  bool _sizedBox = true;
  bool _isAdmin = false;

  void _getOrganization() async {
    orgId = widget.organization.id;
    orgName = widget.organization.orgName.toString();
    orgEmail = widget.organization.orgEmail.toString();
    orgTypeId = widget.organization.orgTypeId;
    orgRegistrationNo = widget.organization.orgRegistrationNo.toString();
    dateExtablished = widget.organization.dateExtablished.toString();
    address1 = widget.organization.address1.toString();
    address2 = widget.organization.address2.toString();
    address3 = widget.organization.address3.toString();
    postcode = widget.organization.postcode.toString();
    phoneNo = widget.organization.phoneNo.toString();
    stateId = widget.organization.stateId;
    districtId = widget.organization.districtId;
    cityId = widget.organization.cityId;
    userId = widget.organization.userId;
  }

  void _getData() async {
    SchedulerBinding.instance
        ?.addPostFrameCallback((_) => showLoadingBar(context));
    _statesModel = await api.getStates();
    _orgTypeModel = await api.getOrganizationType();
    _districtModel = await api.getDistrict(stateId!);
    _cityModel = await api.getCity();
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
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getDataPostcodeCity() async {
    _postcodeCityModel = await api.getPostcodeCity(postcode);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
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

  // Postcode
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListTile(
          title: ListView(
            children: [
              SizedBox(height: 20),
              Visibility(
                visible: _isAdmin,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
                          _isShowCheckOldSSM = !_isShowCheckOldSSM;
                          _sizedBox = !_sizedBox;
                        });
                      },
                      child: _isCanUpdated
                          ? Row(
                              children: [
                                Icon(
                                  LineIcons.edit,
                                ),
                                Text(
                                  'Kemaskini',
                                  style: styles.heading6bold,
                                ),
                              ],
                            )
                          : Row(
                              children: [
                                Icon(
                                  LineIcons.edit,
                                ),
                                Text(
                                  'Batal',
                                  style: styles.heading6bold,
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                autofocus: true,
                enabled: _isReadOnly,
                textInputAction: TextInputAction.next,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('E-mel Organisasi'),
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
              TextFormField(
                enabled: _isReadOnly,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('Nama Organisasi'),
                  filled: _isFilled,
                ),
                initialValue: orgName,
                onChanged: (val) {
                  setState(() {
                    orgName = val;
                  });
                },
              ),
              SizedBox(height: 20),
              IgnorePointer(
                ignoring: _isDisable,
                child: DropdownButtonFormField(
                  isExpanded: true,
                  decoration: styles.inputDecoration.copyWith(
                    enabledBorder: OutlineInputBorder(
                      borderSide: _isDisable
                          ? BorderSide(color: constants.secondaryColor)
                          : BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    label: getRequiredLabel('Jenis Organisasi'),
                    filled: _isFilled,
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
                        orgRegistrationNo = '';
                      } else if (orgTypeId == 7) {
                        //show ROS
                        _isShowCheckOldSSM = false;
                        _isShowOldSSM = false;
                        _isShowSSM = false;
                        _isShowROS = true;
                        _isShowSKM = false;
                        orgRegistrationNo = '';
                      } else if (orgTypeId == 8) {
                        //show SKM
                        _isShowOldSSM = false;
                        _isShowCheckOldSSM = false;
                        _isShowSSM = false;
                        _isShowROS = false;
                        _isShowSKM = true;
                        orgRegistrationNo = '';
                      }
                    });
                  },
                  value: orgTypeId,
                ),
              ),
              // SSM & Lama / ROS / SKM
              Visibility(visible: _sizedBox, child: SizedBox(height: 20)),
              Visibility(
                // visible: _isShowCheckOldSSM,
                visible: _isShowCheckOldSSM,
                child: Row(
                  children: [
                    Checkbox(
                      checkColor: Colors.white,
                      value: _isCheckOldSSM,
                      onChanged: _isReadOnly
                          ? (
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
                            }
                          : null,
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
                    enabled: _isReadOnly,
                    maxLength: 9,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel(
                        'Nombor Pendaftaran SSM Lama ',
                      ),
                      filled: _isFilled,
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
                    enabled: _isReadOnly,
                    maxLength: 12,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel('Nombor Pendaftaran SSM '),
                      filled: _isFilled,
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
                  padding: const EdgeInsets.only(bottom: 7, top: 20),
                  child: TextFormField(
                    enabled: _isReadOnly,
                    maxLength: 19,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel(
                        'Nombor Pendaftaran ROS ',
                      ),
                      filled: _isFilled,
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
                  padding: const EdgeInsets.only(bottom: 7, top: 20),
                  child: TextFormField(
                    enabled: _isReadOnly,
                    maxLength: 8,
                    textInputAction: TextInputAction.next,
                    decoration: styles.inputDecoration.copyWith(
                      label: getRequiredLabel(
                        'Nombor Pendaftaran SKM',
                      ),
                      filled: _isFilled,
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
              // Closed SSM & Lama / ROS / SKM
              TextFormField(
                enabled: _isReadOnly,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('Tarikh ditubuhkan'),
                  filled: _isFilled,
                ),
                initialValue: dateExtablished,
                onChanged: (val) {
                  setState(() {
                    dateExtablished = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                autocorrect: false,
                textInputAction: TextInputAction.next,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('No Telefon'),
                  filled: _isFilled,
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
                enabled: _isReadOnly,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Alamat 1',
                  filled: _isFilled,
                ),
                initialValue: address1,
                onChanged: (val) {
                  setState(() {
                    address1 = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                enabled: _isReadOnly,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Alamat 2',
                  filled: _isFilled,
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
                enabled: _isReadOnly,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Alamat 3',
                  filled: _isFilled,
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
                    child: TextFormField(
                      enabled: _isReadOnly,
                      maxLength: 5,
                      autocorrect: false,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      decoration: styles.inputDecoration.copyWith(
                        label: getRequiredLabel('Poskod'),
                        filled: _isFilled,
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
                          if (postcode.length >= 5) {
                            //? Check if postcode is sah then calling api postcode
                            // _getDataPostcodeState();
                            // _getDataPostcodeCity();
                            _getDataPostcodeCityState();
                          } else {
                            stateId = null;
                            cityId = null;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: IgnorePointer(
                      ignoring: _isDisable,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: styles.inputDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide: _isDisable
                                  ? BorderSide(color: constants.secondaryColor)
                                  : BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: getRequiredLabel('Negeri'),
                            hintText: 'Sila Pilih',
                            filled: _isFilled,
                          ),
                          items: _statesModel.map((item) {
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
                              // districtID = null;
                              // cityID = null;
                              // stateID = newVal as int?;
                              // print(stateID);
                              // _getDataDistrict();
                              stateId = newVal as int?;
                            });
                          },
                          value: stateId,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: IgnorePointer(
                      ignoring: _isDisable,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DropdownButtonFormField(
                          isExpanded: true,
                          decoration: styles.inputDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide: _isDisable
                                  ? BorderSide(color: constants.secondaryColor)
                                  : BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: getRequiredLabel('Daerah'),
                            hintText: 'Sila Pilih',
                            filled: _isFilled,
                          ),
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
                              // districtID = null;
                              // cityID = null;
                              // stateID = newVal as int?;
                              // print(stateID);
                              // _getDataDistrict();
                              districtId = newVal as int?;
                            });
                          },
                          value: districtId,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: IgnorePointer(
                      ignoring: _isDisable,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: DropdownButtonFormField(
                          value: cityId,
                          isExpanded: true,
                          decoration: styles.inputDecoration.copyWith(
                            enabledBorder: OutlineInputBorder(
                              borderSide: _isDisable
                                  ? BorderSide(color: constants.secondaryColor)
                                  : BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            label: getRequiredLabel('Bandar'),
                            hintText: 'Sila Pilih',
                            filled: _isFilled,
                          ),
                          items: _cityModel.map((item) {
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
                              cityId = newVal as int?;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Visibility(
                visible: _isVisibleBtnSubmit,
                child: Column(
                  children: [
                    _isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: SpinKitFoldingCube(
                              color: constants.primaryColor,
                              size: 20,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: PrimaryButton(
                                isLoading: _isLoading,
                                text: 'Kemaskini'.toUpperCase(),
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
                                                await api.updateOrganization(
                                              orgId!,
                                              orgName,
                                              orgEmail,
                                              orgTypeId!,
                                              orgRegistrationNo,
                                              // orgRegistrationNoOld,
                                              dateExtablished,
                                              address1,
                                              address2,
                                              address3,
                                              postcode,
                                              stateId!,
                                              districtId!,
                                              cityId!,
                                              phoneNo,
                                            );
                                            if (response.isSuccessful) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              snack(context,
                                                  'Organisasi berjaya dikemaskini',
                                                  level: SnackLevel.Success);
                                              var homeRoute = MaterialPageRoute(
                                                  builder: (_) =>
                                                      SplashScreen());
                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(homeRoute,
                                                      (route) => false);
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
                                                "Ralat tidak dikenalpasti!");
                                          }
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
