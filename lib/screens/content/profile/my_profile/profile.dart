import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/components/profile/profile_menu.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/content/profile/my_profile/my_account.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/screens/content/profile/help_center/help_center.dart';
import 'package:flutterbase/screens/content/profile/organization/home_organization.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/content/profile/change_password/change_password.dart';
import 'package:flutterbase/utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

bool _isLoading = false;

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    _getData();
  }

  void _getData() async {
    await api.getOrganization();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Widget buildTile(Organization organization) => ListTile(
        title: Text(organization.orgName!),
      );

  @override
  Widget build(BuildContext context) {
    const curveHeight = -20.0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const MyShapeBorder(curveHeight),
      ), //AppB
      body: Container(
        color: Constants().nineColor,
        alignment: Alignment.center,
        child: ValueListenableBuilder(
          valueListenable: state.value.userState,
          builder: (BuildContext context, UserDataState value, Widget? child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: 115,
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        CircleAvatar(
                          backgroundColor: Constants().eightColor,
                          backgroundImage: (state.user.avatarUrl != '')
                              ? NetworkImage(state.user.avatarUrl ?? '')
                              : NetworkImage(
                                  'https://www.w3schools.com/howto/img_avatar.png'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(value.data.firstName!, style: styles.heading6bold),
                  Text(value.data.email!, style: styles.heading2),
                  SizedBox(height: 20),
                  ProfileMenu(
                    text: "Profil",
                    icon: "assets/dist/icon_profile.png",
                    press: () async {
                      await navigate(context, MyAccountScreen());
                      setState(() {});
                    },
                  ),
                  ProfileMenu(
                    text: "Kata Laluan",
                    icon: "assets/dist/icon_password.png",
                    press: () {
                      navigate(context, ChangePasswordScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "Organisasi",
                    icon: "assets/dist/icon_organization.png",
                    press: () {
                      navigate(context, HomeOrganizationScreen());
                    },
                  ),
                  ProfileMenu(
                    text: "Hubungi Kami",
                    icon: "assets/dist/icon_report.png",
                    press: () {
                      navigate(context, HelpCenterScreen());
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: PrimaryButton(
                      isLoading: _isLoading,
                      text: 'Log Keluar'.toUpperCase(),
                      onPressed: () async {
                        logout(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      'Versi : 1.1.1',
                      style: styles.heading14,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
