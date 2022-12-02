import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  String code = '';
  String? path = store.getItem('registerPath');
  String? email = store.getItem('getEmailWidget');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final textEditingController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 50),
          child: Text(
            'Pengaktifan Akaun',
            style: styles.heading1sub,
          ),
        )),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: ListView(
            children: [
              Text(
                'Pendaftaran anda telah berjaya dihantar. Sila semak e-mel <' +
                    store
                        .getItem('getEmailWidget')
                        .replaceRange(1, 8, "*****") +
                    '> untuk pengaktifan akaun anda.',
                textAlign: TextAlign.justify,
                style: styles.heading5,
              ),
              const SizedBox(
                height: 30,
              ),
              PinCodeTextField(
                autoDisposeControllers: false,
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  fieldOuterPadding: const EdgeInsets.only(left: 8, right: 8),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(2),
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                  selectedColor: Colors.black54,
                  selectedFillColor: Colors.white,
                  inactiveColor: Colors.black54,
                  activeColor: Colors.black54,
                ),
                cursorColor: Colors.black,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                autoDismissKeyboard: false,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                mainAxisAlignment: MainAxisAlignment.center,
                onCompleted: (v) {
                  setState(() {
                    code = v;
                  });
                  print("Completed");
                },
                onChanged: (v) {
                  setState(() {
                    code = v;
                  });
                },
                beforeTextPaste: (text) {
                  return true;
                },
              ),
              Visibility(
                visible: false,
                child: TextFormField(
                  autocorrect: false,
                  textInputAction: TextInputAction.done,
                  initialValue: path,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Constants().secondaryColor,
                    enabled: true,
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Sila masukan kata email';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      path = val;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              (code.length < 5)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Tidak terima?'),
                        TextButton(
                          onPressed: () async {
                            await api.resendEmailOTP(email!);
                            snack(
                                context,
                                'Kod baharu telah berjaya dihantar ke e-mel ' +
                                    store.getItem('getEmailWidget'),
                                level: SnackLevel.Success);
                          },
                          child: Column(
                            children: [
                              const Text('Hantar Semula.'),
                            ],
                          ),
                        ),
                      ],
                    )
                  : PrimaryButton(
                      isLoading: _isLoading,
                      text: 'Mengesahkan Akaun',
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() {
                                _isLoading = true;
                              });
                              try {
                                var response =
                                    await api.verifyEmailOTP(code, path!);
                                if (response.isSuccessful) {
                                  var loginRoute = MaterialPageRoute(
                                      builder: (_) => LoginScreen());
                                  setState(() {
                                    _isLoading = false;
                                  });
                                  Navigator.of(context).pushAndRemoveUntil(
                                      loginRoute, (route) => false);
                                  hideSnacks(context);
                                  snack(context,
                                      "Akaun berjaya di aktifkan! Sila log masuk untuk teruskan.",
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
                                snack(context, "Unknown Error!");
                              }
                              setState(() {
                                _isLoading = false;
                              });
                            }),
            ],
          ),
        ),
      ),
      floatingActionButton: (code.length == 5)
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.cleaning_services),
              onPressed: () {
                setState(() {
                  code = '';
                  textEditingController.text = '';
                });
              },
            ),
    );
  }
}
