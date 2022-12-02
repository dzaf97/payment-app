import 'package:flutter/material.dart';
import 'package:flutterbase/screens/content/bill/placeholder_bill.dart';
import 'package:flutterbase/screens/content/history/placeholder_history.dart';
import 'package:flutterbase/screens/content/notification/placeholder_notification.dart';
import 'package:flutterbase/screens/content/profile/my_profile/profile.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

import 'home.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final PageController controller = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: Scaffold(
        extendBody: false,
        body: TabBarView(
          children: [
            HomeScreen(),
            PlaceholderBillingScreen(),
            PlaceholderHistoryScreen(),
            PlaceholderNotificationScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(bottom: 15),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
              ),
            ],
          ),
          child: TabBar(
            indicatorColor: Colors.transparent,
            labelColor: constants.primaryColor,
            unselectedLabelColor: const Color(0xffAAAAAA),
            labelStyle: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.normal,
            ),
            tabs: [
              Tab(
                icon: const Icon(LineIcons.home),
                text: 'Utama',
              ),
              Tab(
                icon: const Icon(LineIcons.fileInvoice),
                text: 'Bil',
              ),
              Tab(
                icon: const Icon(LineIcons.history),
                text: 'Sejarah',
              ),
              Tab(
                icon: Stack(children: const [
                  Icon(LineIcons.bell),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: Icon(Icons.brightness_1,
                        size: 8.0, color: Colors.redAccent),
                  )
                ]),
                text: 'Notifikasi',
              ),
              Tab(
                icon: const Icon(LineIcons.user),
                text: 'Profil',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
