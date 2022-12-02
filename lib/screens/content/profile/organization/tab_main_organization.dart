import 'package:flutter/material.dart';
import 'package:flutterbase/components/loading_indicator.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/content/profile/organization/tab/detail_organization.dart';
import 'package:flutterbase/screens/content/profile/organization/tab/view_member.dart';
import 'package:flutterbase/utils/constants.dart';

class TabMainOrganizationScreen extends StatefulWidget {
  final Organization organization;
  const TabMainOrganizationScreen(this.organization, {Key? key})
      : super(key: key);

  @override
  State<TabMainOrganizationScreen> createState() =>
      _TabMainOrganizationScreenState();
}

class _TabMainOrganizationScreenState extends State<TabMainOrganizationScreen>
    with TickerProviderStateMixin {
  bool isOnline = true;
  bool showLoader = true;

  int tabIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState(() {
        tabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(120.0),
        child: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 55),
              child: Text(
                'Organisasi',
                style: styles.heading1sub,
              ),
            ),
          ),
          backgroundColor: constants.primaryColor,
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.black,
            unselectedLabelColor: Colors.white,
            labelColor: Constants().sixColor,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicator: BoxDecoration(
              color: Constants().splashColor,
            ),
            tabs: [
              Tab(
                text: 'Butiran',
              ),
              Tab(
                text: 'Ahli',
              ),
            ],
          ),
        ),
      ),
      body: (!isOnline)
          ? Center(
              child: !isOnline
                  ? const Text('Offline')
                  : const Center(child: LoadingIndicator()))
          : TabBarView(
              controller: _tabController,
              children: [
                DetailOrganizationScreen(widget.organization),
                ViewMemberScreen(widget.organization),
              ],
            ),
    );
  }
}
