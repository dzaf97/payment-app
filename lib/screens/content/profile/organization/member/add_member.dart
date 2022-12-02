import 'package:flutterbase/api/api.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterbase/models/organizations/organization.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class AddMemberScreen extends StatefulWidget {
  final Organization organization;
  const AddMemberScreen(this.organization, {Key? key});

  @override
  _AddMemberScreenState createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  TextEditingController verifiedIcNo = TextEditingController();

  bool _isBtnAddDisable = false;

  int? orgID;
  List<String> icNo = [];

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    var oId = widget.organization.id;
    orgID = oId;
  }

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isEnabled = false;
  bool _isShowList = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Tambah Ahli',
          style: styles.heading1sub,
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Masukkan nombor identiti pengguna untuk membuat penambahan ahli dalam organisasi",
                    style: styles.heading5,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          maxLength: 12,
                          controller: verifiedIcNo,
                          style: styles.heading2,
                          keyboardType: TextInputType.number,
                          decoration: styles.inputDecoration.copyWith(
                            labelText: 'Nombor Identiti Pengguna',
                            hintText: 'Masukkan MYKAD, MYPR, Passport',
                            hintStyle: styles.heading2,
                            suffixIcon: Icon(LineIcons.identificationBadge),
                          ),
                          onChanged: (val) {
                            setState(() {
                              val = verifiedIcNo.text;
                              _isBtnAddDisable = true;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Card(
                            color: _isBtnAddDisable
                                ? constants.sixColor
                                : constants.secondaryColor,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(8),
                              onTap: _isBtnAddDisable
                                  ? () {
                                      setState(() {
                                        icNo.add(verifiedIcNo.text);
                                        _isShowList = true;
                                        _isEnabled = true;
                                        _isBtnAddDisable = false;
                                        verifiedIcNo.clear();
                                      });
                                    }
                                  : null,
                              child: Container(
                                height: 50,
                                child: Icon(LineIcons.plusCircle),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: _isShowList,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Card(
                        color: constants.secondaryColor,
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                for (var item in icNo)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 7),
                                        child: Row(
                                          children: [
                                            Icon(
                                              LineIcons.userCircle,
                                              color: Colors.black,
                                            ),
                                            SizedBox(width: 10),
                                            Text(item,
                                                style: styles.heading6bold),
                                          ],
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            print(icNo.length);
                                            if (icNo.length == 1) {
                                              icNo.removeAt(icNo.indexOf(item));
                                              _isShowList = false;
                                              _isEnabled = false;
                                            } else if (icNo.length > 1) {
                                              icNo.removeAt(icNo.indexOf(item));
                                            }
                                          });
                                        },
                                        child: Icon(
                                          LineIcons.trash,
                                          color: Colors.redAccent,
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
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    child: Column(
                      children: [
                        _isLoading
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: SpinKitFoldingCube(
                                  color: constants.primaryColor,
                                  size: 20,
                                ),
                              )
                            : PrimaryButton(
                                isLoading: _isLoading,
                                text: 'Tambah Ahli'.toUpperCase(),
                                onPressed: !_isEnabled
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
                                            var response = await api.addMember(
                                                orgID!, icNo);
                                            if (response.isSuccessful) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                              snack(context,
                                                  'Ahli berjaya ditambah !',
                                                  level: SnackLevel.Success);

                                              Navigator.pop(context);

                                              return;
                                            }
                                            hideSnacks(context);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            snack(context, response.message,
                                                level: SnackLevel.Error);
                                          } catch (e) {
                                            snack(context,
                                                "Ralat tidak dapat dikenalpasti!");
                                          }
                                        }
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
