import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/organizations/list_organization_member.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/content/profile/organization/member/add_member.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class ViewMemberScreen extends StatefulWidget {
  final Organization organization;
  const ViewMemberScreen(this.organization, {Key? key});
  @override
  State<ViewMemberScreen> createState() => _ViewMemberScreenState();
}

class _ViewMemberScreenState extends State<ViewMemberScreen> {
  List<ListOrganizationMember> _memberModel = [];
  bool _isAdmin = false;
  int? userId;
  @override
  void initState() {
    super.initState();
    _getData();
    userId = widget.organization.userId;
    if (userId == state.user.id) {
      _isAdmin = true;
    } else {
      _isAdmin = false;
    }
  }

  void _getData() async {
    var oId = widget.organization.id;
    print(oId);
    _memberModel = (await api.getOrganizationMember(oId!));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Visibility(
        visible: _isAdmin,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
              child: Card(
                color: constants.secondaryColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    //Make screen refresh after pop up
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddMemberScreen(widget.organization),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          Icon(LineIcons.plusCircle),
                          SizedBox(width: 30),
                          Text(
                            'Tambah Ahli Organisasi',
                            style: styles.heading6bold,
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
      _memberModel.isEmpty
          ? Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  children: [
                    Text(
                      'Tiada lagi ahli yang berdaftar dibawah organisasi ini.',
                      style: styles.heading5,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget.organization.orgName.toString(),
                              style: styles.heading6bold,
                            ),
                          ),
                          Text(
                            widget.organization.orgEmail.toString(),
                            style: styles.heading2,
                          ),
                          Text(
                            widget.organization.orgRegistrationNo.toString(),
                            style: styles.heading2,
                          ),
                          Text(
                            widget.organization.phoneNo.toString(),
                            style: styles.heading2,
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Senarai Ahli',
                            style: styles.heading5bold,
                          ),
                          Text(
                            _memberModel.length.toString() + ' Ahli',
                            style: styles.heading6bold,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: _memberModel.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Card(
                                color: constants.secondaryColor,
                                child: ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(LineIcons.user),
                                            SizedBox(width: 16),
                                            Text(
                                              _memberModel[index]
                                                  .user!
                                                  .firstName
                                                  .toString(),
                                              style: styles.heading6bold,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(LineIcons.user),
                                            SizedBox(width: 16),
                                            Text(
                                                _memberModel[index]
                                                    .user!
                                                    .lastName
                                                    .toString(),
                                                style: styles.heading2),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(LineIcons.mailBulk),
                                            SizedBox(width: 16),
                                            Text(
                                                _memberModel[index]
                                                    .user!
                                                    .email
                                                    .toString(),
                                                style: styles.heading3),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            )
    ])));
  }
}
