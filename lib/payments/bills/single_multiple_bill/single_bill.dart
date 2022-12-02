import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/payments/bills/single_multiple_bill/multiple_bill.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class SingleBillScreen extends StatefulWidget {
  const SingleBillScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SingleBillScreen> createState() => _SingleBillScreenState();
}

bool _isEmpty = false;
int counter = 1;
int amount = 200;
String accountNo = '';

List productModel = [
  'No. rujukan bil',
  'No. identiti pelanggan',
];

class _SingleBillScreenState extends State<SingleBillScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
            child: Text(
          'Bil',
          style: styles.heading1sub,
        )),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              var homeRoute =
                  MaterialPageRoute(builder: (_) => const MenuScreen());
              Navigator.of(context)
                  .pushAndRemoveUntil(homeRoute, (route) => false);
            },
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: Column(
          children: [
            Image.asset(
              'assets/dist/submenu_icon.png',
              height: 200,
            ),
            // Text(widget.menu.name.replaceAll("\r\n", ' ')),
            // Text(widget.service.title),
            // SizedBox(height: 40),
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: styles.inputDecoration.copyWith(
                label: getRequiredLabel('Nombor Akaun'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Sila masukkan nambor akaun';
                }
                return null;
              },
              onChanged: (val) {
                if (val.length >= 1) {
                  setState(() {
                    _isEmpty = true;
                    accountNo = val;
                  });
                } else {
                  setState(() {
                    _isEmpty = false;
                    accountNo = val;
                  });
                }
              },
            ),
            SizedBox(height: 30),
            PrimaryButton(
              onPressed: !_isEmpty
                  ? null
                  : () {
                      if (accountNo == '12345') {
                        print('Multiple');
                        navigate(context, MultipleBillScreen());
                      } else {
                        print('Single');
                        showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                              ),
                            ),
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 370,
                                child: Padding(
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bil',
                                        style: styles.heading11,
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'TASKA KREATIF KAMPUS',
                                        style: styles.heading5bold,
                                      ),
                                      SizedBox(height: 13),
                                      Text(
                                        'Jumlah Bil',
                                        style: styles.heading11,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'RM 175.00',
                                              style: styles.heading12bold,
                                            ),
                                            Container(
                                              height: 24,
                                              width: 92,
                                              decoration: BoxDecoration(
                                                color: const Color(0xffd3eaff),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: Material(
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  onTap: () {},
                                                  child: Center(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 3),
                                                      child: Text(
                                                        'Lanjut',
                                                        style: GoogleFonts.openSans(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xff6ebaff)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]),
                                      SizedBox(height: 13),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text('No Akaun :'),
                                              Text('No. Pendaftaran  :'),
                                              Text('Tarikh :'),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text('L6024116'),
                                              Text('TI-002/2020'),
                                              Text('28/4/2017, 1:22pm'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: List.generate(
                                            700 ~/ 10,
                                            (index) => Expanded(
                                                  child: Container(
                                                    color: index % 2 == 0
                                                        ? Colors.transparent
                                                        : constants
                                                            .secondaryColor,
                                                    height: 1,
                                                  ),
                                                )),
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: PrimaryButton(
                                          text: 'Bayar',
                                          onPressed: () async {
                                            confirmPayment(context, 175, '01', [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.black,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            'Bayar RM 175.00 ?',
                                                        style: TextStyle(
                                                          color: constants
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ]);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    },
              text: 'Semak',
            ),
          ],
        ),
      ),
    );
  }
}
