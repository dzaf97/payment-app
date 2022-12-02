import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/models/users/identity_type.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class ForgotUserIDScreen extends StatefulWidget {
  ForgotUserIDScreen({Key? key}) : super(key: key);

  @override
  _ForgotUserIDScreenState createState() => _ForgotUserIDScreenState();
}

class _ForgotUserIDScreenState extends State<ForgotUserIDScreen> {
  final myController = TextEditingController();

  bool isLoading = false;
  String identityNo = '';
  int? userIdentityTypeId;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _identityType();
  }

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isVisible = false;
  bool citizenship = true;

  List<String> citizenshipModel = ['Warganegara', 'Bukan Warganegara'];
  List<IdentityType> _identityTypeAllModel = [];

  void _identityType() async {
    _identityTypeAllModel = await api.getIndentityTypeAll();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Lupa ID Pengguna',
          style: styles.heading1sub,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            children: [
              Text(
                "Masukkan identiti pengguna dan kami akan mencarinya untuk anda.",
                style: styles.heading2sub,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              Container(
                child: new DropdownButtonFormField(
                  value: userIdentityTypeId,
                  isExpanded: true,
                  decoration: styles.inputDecoration.copyWith(
                    label: getRequiredLabel('Jenis Identiti Pengguna'),
                  ),
                  hint: Text('Pilih Jenis Identiti Pengguna'),
                  items: _identityTypeAllModel.map((item) {
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
                  onChanged: (newVal) {
                    setState(() {
                      print(newVal);
                      userIdentityTypeId = newVal as int;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                style: styles.heading2,
                keyboardType: TextInputType.number,
                decoration: styles.inputDecoration.copyWith(
                  labelText: 'Identiti Pengguna',
                  hintText: 'Masukkan MYKAD, MYPR, Passport',
                  hintStyle: styles.heading2,
                  suffixIcon: Icon(LineIcons.identificationBadge),
                ),
                initialValue: identityNo,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Sila pilih jenis identiti pengguna';
                  }
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    identityNo = val;
                  });
                },
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
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
                        : PrimaryButton(
                            isLoading: _isLoading,
                            text: 'Carian'.toUpperCase(),
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      try {
                                        var response = await api.forgotUserID(
                                            identityNo, userIdentityTypeId!);
                                        if (response.isSuccessful) {
                                          setState(() {
                                            _isLoading = false;
                                          });

                                          _isVisible = true;
                                          snack(
                                              context,
                                              'ID Pengguna berjaya didapatkan:' +
                                                  store
                                                      .getItem('getUserID')
                                                      .toString(),
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
                                        snack(context, 'Catch capture error',
                                            level: SnackLevel.Error);
                                      }
                                    }
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }),
                    SizedBox(height: 100),
                    Visibility(
                      visible: _isVisible,
                      child: Column(
                        children: [
                          Text('ID Pengguna anda ialah:'),
                          SizedBox(height: 10),
                          Text(
                            store.getItem('getUserID').toString(),
                            style: styles.heading6bold,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
