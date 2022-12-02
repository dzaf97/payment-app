import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/screens/auth/forgot_password.dart';
import 'package:flutterbase/screens/auth/forgot_user_id.dart';
import 'package:flutterbase/screens/auth/register.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  late FocusNode passwordFocusNode;

  bool _isVisible = false;
  bool isLoading = false;
  bool isCheckedForgotUserID = false;

  String _username = '';
  String _password = '';

  void initState() {
    super.initState();
    passwordFocusNode = FocusNode();
    _getSharedPref();
  }

  void _getSharedPref() async {
    setState(() {
      _username = credentialStore.getItem('_username') ?? '';
    });
    print(_username);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: 370,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/dist/bg_laucher.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset('assets/dist/Plus.svg',
                            height: MediaQuery.of(context).size.width / 8),
                        SizedBox(height: 140),
                        Text("Log Masuk", style: styles.heading1),
                        SizedBox(height: 10),
                        Text("Sila log masuk untuk teruskan",
                            style: styles.heading1sub),
                        SizedBox(height: 100),
                        TextFormField(
                          initialValue: _username,
                          autocorrect: false,
                          textInputAction: TextInputAction.next,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Alamat Emel',
                          ),
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Sila masukan alamat emel';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              _username = val;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            navigate(context, ForgotUserIDScreen());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Lupa ID Pengguna?",
                              style: styles.heading6,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Sila masukan kata laluan';
                            }
                            return null;
                          },
                          focusNode: passwordFocusNode,
                          obscureText: !_isVisible,
                          style: styles.heading5,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Kata Laluan',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isVisible = !_isVisible;
                                });
                              },
                              icon: _isVisible
                                  ? Icon(
                                      Icons.visibility,
                                      color: Colors.black,
                                    )
                                  : Icon(
                                      Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                            ),
                            enabled: true,
                          ),
                          initialValue: _password,
                          onChanged: (val) {
                            setState(() {
                              _password = val;
                            });
                          },
                        ),
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            navigate(context, ForgotPasswordScreen());
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Lupa Kata Laluan?",
                              style: styles.heading6,
                            ),
                          ),
                        ),
                        SizedBox(height: 25),
                        isLoading
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: SpinKitFoldingCube(
                                  color: constants.secondaryColor,
                                  size: 20,
                                ),
                              )
                            : PrimaryButton(
                                isLoading: isLoading,
                                text: 'Log Masuk'.toUpperCase(),
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
                                            var response = await api.login(
                                                _username, _password);
                                            if (response.isSuccessful) {
                                              var homeRoute = MaterialPageRoute(
                                                  builder: (_) => MenuScreen());

                                              setState(() {
                                                isLoading = false;
                                              });
                                              await credentialStore.setItem(
                                                  '_username', _username);

                                              Navigator.of(context)
                                                  .pushAndRemoveUntil(homeRoute,
                                                      (route) => false);
                                              hideSnacks(context);
                                              snack(
                                                  context,
                                                  'Selamat datang ' +
                                                      state.user.firstName! +
                                                      '!',
                                                  level: SnackLevel.Success);
                                              return;
                                            }
                                            // if (response.message ==
                                            //     "ID pengguna atau kata laluan belum diaktifkan.") {
                                            //   print('navigate to verify');
                                            // }
                                            hideSnacks(context);
                                            setState(() {
                                              isLoading = false;
                                            });
                                            snack(context, response.message,
                                                level: SnackLevel.Error);
                                          } catch (e) {
                                            snack(context, "Unknown Error!");
                                          }
                                        }
                                        setState(() {
                                          isLoading = false;
                                        });
                                      }),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Belum mempunyai akaun?",
                                    style: styles.heading2,
                                  ),
                                  SizedBox(width: 5),
                                  GestureDetector(
                                    onTap: () {
                                      navigate(context, RegisterScreen());
                                    },
                                    child: Text("Daftar",
                                        style: styles.heading6bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
