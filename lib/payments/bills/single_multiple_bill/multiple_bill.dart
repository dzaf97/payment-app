import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class MultipleBillScreen extends StatefulWidget {
  const MultipleBillScreen({Key? key}) : super(key: key);

  @override
  _MultipleBillScreenState createState() => _MultipleBillScreenState();
}

bool allChecked = false;
bool _isVisibileBtn = false;

class _MultipleBillScreenState extends State<MultipleBillScreen> {
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
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 16),
                    child: Row(
                      children: [
                        Text("Rekod yang dijumpai",
                            style: styles.heading10bold),
                        const SizedBox(width: 5),
                        Text('(4)', style: styles.heading13),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 8),
                    child: Text("Pilih bayaran yang ingin dibuat",
                        style: styles.heading12bold),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        side: const BorderSide(
                          color: Colors.grey,
                          width: 1.5,
                        ),
                        checkColor: Colors.white,
                        activeColor: Colors.amber,
                        value: allChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            allChecked = !allChecked;
                            _isVisibileBtn = !_isVisibileBtn;
                          });
                        },
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'Pilih Semua',
                            style: styles.heading10bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xFFF5F6F9),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Colors.amber,
                                      value: allChecked,
                                      onChanged: (bool? value) {
                                        if (value != null) {}
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Jumlah Bil',
                                          style: styles.heading11,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'RM 24.00',
                                          style: styles.heading12bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 13),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('No Bil :'),
                                        Text('Tarikh :'),
                                        Text('Lokasi :'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('L6024116'),
                                        Text('28/4/2017, 1:22pm'),
                                        Text('JALAN PUTRA SQUARE 6'),
                                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xFFF5F6F9),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Colors.amber,
                                      value: allChecked,
                                      onChanged: (bool? value) {
                                        if (value != null) {}
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Jumlah Bil',
                                          style: styles.heading11,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'RM 143.00',
                                          style: styles.heading12bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 13),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('No Bil :'),
                                        Text('Tarikh :'),
                                        Text('Lokasi :'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('L6024116'),
                                        Text('28/4/2017, 1:22pm'),
                                        Text('JALAN PUTRA SQUARE 6'),
                                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xFFF5F6F9),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Colors.amber,
                                      value: allChecked,
                                      onChanged: (bool? value) {
                                        if (value != null) {}
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Jumlah Bil',
                                          style: styles.heading11,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'RM 62.00',
                                          style: styles.heading12bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 13),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('No Bil :'),
                                        Text('Tarikh :'),
                                        Text('Lokasi :'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('L6024116'),
                                        Text('28/4/2017, 1:22pm'),
                                        Text('JALAN PUTRA SQUARE 6'),
                                      ],
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xFFF5F6F9),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {},
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      side: const BorderSide(
                                        color: Colors.grey,
                                        width: 1.5,
                                      ),
                                      checkColor: Colors.white,
                                      activeColor: Colors.amber,
                                      value: allChecked,
                                      onChanged: (bool? value) {
                                        if (value != null) {}
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Jumlah Bil',
                                          style: styles.heading11,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'RM 33.00',
                                          style: styles.heading12bold,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 13),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('No Bil :'),
                                        Text('Tarikh :'),
                                        Text('Lokasi :'),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text('L6024116'),
                                        Text('28/4/2017, 1:22pm'),
                                        Text('JALAN PUTRA SQUARE 6'),
                                      ],
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
              Visibility(
                visible: _isVisibileBtn,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: AddToCartButton(
                          onPressed: () {},
                          icon: LineIcons.addToShoppingCart,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 8,
                        child: PrimaryButton(
                          onPressed: () {
                            confirmPayment(context, 243, '01', [
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                        text: 'Bayar RM 243.00 ?',
                                        style: TextStyle(
                                          color: constants.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ],
                                ),
                              ),
                            ]);
                          },
                          text: 'Bayar',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
