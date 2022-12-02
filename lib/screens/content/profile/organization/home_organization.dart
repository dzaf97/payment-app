import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/screens/content/profile/organization/add_organization.dart';
import 'package:flutterbase/screens/content/profile/organization/tab_main_organization.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';

class HomeOrganizationScreen extends StatefulWidget {
  @override
  State<HomeOrganizationScreen> createState() => _HomeOrganizationScreenState();
}

class _HomeOrganizationScreenState extends State<HomeOrganizationScreen> {
  List<Organization> _organizationModel = [];
  int? orgId;
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _organizationModel = await api.getOrganization();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Widget buildTile(Organization organization) => ListTile(
        title: Text(organization.orgName!),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            LineIcons.angleLeft,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Senarai Organisasi',
          style: styles.heading1sub,
        ),
      ), //AppB
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Card(
                color: constants.secondaryColor,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () {
                    navigate(context, AddOrganizationScreen());
                  },
                  child: Container(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(width: 30),
                          Icon(LineIcons.plusCircle),
                          SizedBox(width: 10),
                          Text(
                            'Daftar Organisasi Baharu',
                            style: styles.heading6bold,
                          ),
                        ],
                      )),
                ),
              ),
            ),
            _organizationModel.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          Text(
                            'Tiada organisasi yang didaftarkan di atas pengguna.',
                            style: styles.heading5,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Senarai Organisasi',
                              style: styles.heading5bold,
                            ),
                            Text(
                              _organizationModel.length.toString() +
                                  ' Organisasi',
                              style: styles.heading6bold,
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Text(
                          'Tekan lama untuk hapus organisasi',
                          style: styles.heading14sub,
                        ),
                      ],
                    ),
                  ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: _organizationModel.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
                          child: Card(
                            color: Color(0xffF1F3F6),
                            child: InkWell(
                              onTap: () {
                                print(index);
                                setState(() {
                                  orgId = _organizationModel[index].id;
                                });
                                navigate(
                                    context,
                                    TabMainOrganizationScreen(
                                        _organizationModel[index]));
                              },
                              onLongPress: () async {
                                var response =
                                    await deleteConfirmation(context, [
                                  Title(
                                    color: Colors.black,
                                    child: Text(
                                      'Hapus organisasi'.toUpperCase(),
                                      style: styles.heading9bold,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Adakah anda pasti untuk menghapuskan maklumat organisasi " +
                                              _organizationModel[index]
                                                  .orgName
                                                  .toString() +
                                              "?",
                                          style: TextStyle(
                                              color: Color(0xff666666)),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                            '**Organisasi yang telah dihapus tidak dapat dikembalikan lagi.',
                                            style: const TextStyle(
                                                color: Color(0xff666666),
                                                fontSize: 12),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  )
                                ]);
                                if (response == 'yes') {
                                  await api.organizationDeleted(
                                      _organizationModel[index].id);
                                  snack(
                                      context, ('Organisasi berjaya dihapus.'),
                                      level: SnackLevel.Success);
                                  back(context);
                                }
                              },
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(LineIcons.identificationCard),
                                          SizedBox(width: 16),
                                          Text(
                                            _organizationModel[index]
                                                .orgName
                                                .toString(),
                                            style: styles.heading6bold,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(LineIcons.identificationBadge),
                                          SizedBox(width: 16),
                                          Text(
                                              _organizationModel[index]
                                                  .orgRegistrationNo
                                                  .toString(),
                                              style: styles.heading2),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(LineIcons.mailBulk),
                                          SizedBox(width: 16),
                                          Text(
                                              _organizationModel[index]
                                                  .orgEmail
                                                  .toString(),
                                              style: styles.heading2),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(LineIcons.identificationCard),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Text(
                                              _organizationModel[index]
                                                  .address1
                                                  .toString(),
                                              style: styles.heading2,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
