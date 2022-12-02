import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/auth/login.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacity = 0;
  bool isLoading = true;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1)).then((_) {
      setState(() {
        opacity = 1;
      });
    });

    credentialStore.ready.then((_) async {
      store.ready.then((_) async {
        var _loggedIn = await api.resume();

        setState(() {
          isLoading = false;
          isLoggedIn = _loggedIn;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/dist/bg_laucher.png'),
          ),
        ),
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          opacity: opacity,
          onEnd: () async {
            if (opacity == 1) {
              await Future(() => !isLoading);
              await Future.delayed(const Duration(seconds: 3));
              setState(() {
                opacity = 0;
              });
            } else {
              loadApp(context);
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/dist/Plus.svg',
                        height: MediaQuery.of(context).size.width / 7,
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          "iPayment",
                          style: styles.heading4,
                        ),
                      ),
                      SizedBox(height: 180),
                      SpinKitFoldingCube(
                        color: Constants().secondaryColor,
                        size: 25,
                      ),
                    ],
                  ),
                ),
                Text(
                  "Oleh:",
                  style: styles.heading4,
                ),
                SizedBox(height: 12),
                Text(
                  "Jabatan Akauntan Negara Malaysia",
                  style: styles.heading4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  loadApp(BuildContext context) {
    var nextRoute = MaterialPageRoute(builder: (_) => LoginScreen());

    if (isLoggedIn) {
      snack(context, 'Selamat kembali ' + state.user.firstName! + '!',
          level: SnackLevel.Success);
      nextRoute = MaterialPageRoute(builder: (_) => const MenuScreen());
    }
    Navigator.of(context).pushReplacement(nextRoute);
  }
}
