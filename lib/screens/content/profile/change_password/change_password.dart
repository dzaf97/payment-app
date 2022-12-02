import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/screens/auth/forgot_password.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String currentPassword = '';
  String password = '';
  String passwordConfirmation = '';

  @override
  void dispose() {
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  bool isChecked = false;
  bool isLoading = false;
  bool _isVisiblePass = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  // Password
  onChangedPassword(String passwordPattern) {
    final passwordValid = RegExp(
        r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&.\/])[A-Za-z\d@$!%*?&.\/]{8,20}$");

    setState(
      () {
        _isPasswordValid = false;
        if (passwordValid.hasMatch(passwordPattern)) _isPasswordValid = true;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Tukar Kata Laluan',
          style: styles.heading1sub,
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: [
                SizedBox(height: 30),
                TextFormField(
                  obscureText: !_isVisiblePass,
                  decoration: styles.inputDecoration.copyWith(
                    labelText: 'Kata Laluan Semasa',
                    suffixIcon: IconButton(
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
                  ),
                  initialValue: currentPassword,
                  onChanged: (val) {
                    setState(() {
                      currentPassword = val;
                    });
                  },
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    navigate(context, ForgotPasswordScreen());
                  },
                  child: Text(
                    "Lupa Kata Laluan?",
                    style: styles.heading6,
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: password,
                  decoration: styles.inputDecoration.copyWith(
                    labelText: 'Kata Laluan Baharu',
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a new password';
                    } else if (value.length < 8) {
                      return 'Enter at least 8 characters';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      password = val;
                      onChangedPassword(password);
                      password = password;
                    });
                  },
                  obscureText: !_isVisiblePass,
                ),
                SizedBox(height: 16),
                TextFormField(
                  initialValue: passwordConfirmation,
                  decoration: styles.inputDecoration.copyWith(
                    labelText: 'Pengesahan Kata Laluan Baharu',
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
                  onChanged: (val) {
                    setState(() {
                      passwordConfirmation = val;
                      onChangedConfirmPassword(passwordConfirmation);
                      passwordConfirmation = passwordConfirmation;
                    });
                  },
                  obscureText: !_isVisiblePass,
                ),
                SizedBox(height: 30),
                Column(
                  children: [
                    isLoading
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: SpinKitFoldingCube(
                              color: constants.primaryColor,
                              size: 20,
                            ),
                          )
                        : PrimaryButton(
                            isLoading: isLoading,
                            text: 'Tukar kata laluan'.toUpperCase(),
                            onPressed: isLoading
                                ? null
                                : () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      try {
                                        var response = await api.changePassword(
                                            currentPassword,
                                            password,
                                            passwordConfirmation);
                                        if (response.isSuccessful) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          snack(context,
                                              'Kata laluan berjaya dikemasini. ',
                                              level: SnackLevel.Success);
                                          logout(context);
                                          return;
                                        }
                                        hideSnacks(context);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        snack(context, response.message,
                                            level: SnackLevel.Error);
                                      } catch (e) {
                                        snack(context, "Unknown Error!",
                                            level: SnackLevel.Warning);
                                      }
                                    }
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
