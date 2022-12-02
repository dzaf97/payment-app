import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/screens/auth/forgot_user_id.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:line_icons/line_icons.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final myController = TextEditingController();

  bool isLoading = false;
  String _email = '';

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _isEmailValid = false;

  // Email validation
  onEmailChanged(String email) {
    final emailValid = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    setState(
      () {
        _isEmailValid = false;
        if (emailValid.hasMatch(email)) _isEmailValid = true;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Lupa Kata Laluan',
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
                "Masukkan alamat e-mel dan kami akan menghantar pautan untuk menetapkan semula kata laluan anda.",
                style: styles.heading2sub,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextFormField(
                onChanged: (email) {
                  onEmailChanged(email);
                  _email = email;
                },
                style: styles.heading5,
                decoration: styles.inputDecoration.copyWith(
                  label: getRequiredLabel('Alamat E-mel'),
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
                initialValue: _email,
                validator: MultiValidator(
                  [
                    RequiredValidator(errorText: "Masukkan alamat e-mel."),
                    EmailValidator(
                        errorText: "Masukkan alamat e-mel yang sah."),
                  ],
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  navigate(context, ForgotUserIDScreen());
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Lupa Alamat Emel?",
                    style: styles.heading6,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(children: [
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
                          text: 'Hantar Pautan Set Semula'.toUpperCase(),
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
                                          await api.forgotPassword(_email);
                                      if (response.isSuccessful) {
                                        var homeRoute = MaterialPageRoute(
                                            builder: (_) => LoginScreen());
                                        setState(() {
                                          _isLoading = false;
                                        });
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                homeRoute, (route) => false);
                                        hideSnacks(context);
                                        snack(context, response.message,
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
                                      snack(context, 'Unknown Error',
                                          level: SnackLevel.Error);
                                    }
                                  }
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
