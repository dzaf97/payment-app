import 'package:flutter/material.dart';
import 'package:flutterbase/components/add_to_cart_button.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/payments/bills/bill_without_amount/bill_without_amount.dart';
import 'package:flutterbase/payments/bills/payment_without_bill/payment_without_bill_toursim.dart';
import 'package:flutterbase/payments/bills/payment_without_bill_and_amount/payment_without_bill_and_amount.dart';
import 'package:flutterbase/payments/bills/rateless_payment/rateless_payment.dart';
import 'package:flutterbase/payments/bills/single_multiple_bill/single_bill.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class PlaceholderBillingScreen extends StatefulWidget {
  const PlaceholderBillingScreen({Key? key}) : super(key: key);

  @override
  State<PlaceholderBillingScreen> createState() =>
      _PlaceholderBillingScreenState();
}

bool allChecked = false;
bool _isVisibileBtn = false;
bool _isSearching = false;

class _PlaceholderBillingScreenState extends State<PlaceholderBillingScreen> {
  @override
  Widget build(BuildContext context) {
    const curveHeight = -20.0;
    return Scaffold(
      appBar: AppBar(
          shape: const MyShapeBorder(curveHeight),
          automaticallyImplyLeading: false),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Heading(),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Senarai Bil',
                            style: styles.heading8,
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Senarai bil yang perlu dibayar',
                            style: styles.heading8sub,
                          ),
                        ],
                      ),
                    ),
                    // Searchbar
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: styles.inputDecoration.copyWith(
                            labelText: 'Carian',
                            prefixIcon: LineIcon(Icons.search)),
                        onChanged: (val) {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                      ),
                    ),
                    //Jumlah keseluruhan
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
                      child: Visibility(
                        visible: _isSearching,
                        child: Column(
                          children: [
                            Card(
                              elevation: 2,
                              color: Constants().primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {},
                                child: Container(
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Jumlah Keseluruhan',
                                            style: styles.heading1sub2),
                                        SizedBox(height: 10),
                                        Text('RM 8,500.00',
                                            style: styles.heading1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                Text("Rekod yang dijumpai",
                                    style: styles.heading14sub),
                                const SizedBox(width: 5),
                                Text('(1)', style: styles.heading13),
                              ],
                            ),
                            const SizedBox(height: 5),
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
                                      style: styles.heading10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Card(
                              elevation: 0,
                              color: Color(0xFFF5F6F9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(8),
                                onTap: () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // for (var item in bills)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Checkbox(
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'Jumlah Bil',
                                                  style: styles.heading11,
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'RM 24.00',
                                                      style:
                                                          styles.heading12bold,
                                                    ),
                                                    Icon(
                                                      LineIcons.pdfFile,
                                                      color: Constants()
                                                          .primaryColor,
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Klj . Komuniti Paya Besar',
                                          style: styles.heading14sub,
                                        ),
                                        SizedBox(height: 10),
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
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text('L6024116'),
                                                Text('28/4/2017, 1:22pm'),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

class Heading extends StatelessWidget {
  const Heading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text('Bil Komitmen',
                      style: GoogleFonts.openSans(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ),
              ),
              Icon(
                LineIcons.addToShoppingCart,
                color: Constants().primaryColor,
                size: 35,
              ),
            ],
          ),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                navigate(context, SingleBillScreen());
              },
              child: Text('Bil')),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                navigate(context, BillWithoutAmountScreen());
              },
              child: Text('Bil Tanpa Amount')),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                navigate(context, PaymentWithoutBillTourismScreen());
              },
              child: Text('Bayar Tanpa Bil')),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                navigate(context, PaymentWithoutBillAndAmountScreen());
              },
              child: Text('Bil Tanpa Bil dan Amount')),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                navigate(context, RatelessPaymentScreen());
              },
              child: Text('Bayar Tanpa Kadar')),
        ],
      ),
    );
  }
}
