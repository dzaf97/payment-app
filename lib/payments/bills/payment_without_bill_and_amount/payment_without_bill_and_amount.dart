import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class PaymentWithoutBillAndAmountScreen extends StatefulWidget {
  const PaymentWithoutBillAndAmountScreen({Key? key}) : super(key: key);

  @override
  State<PaymentWithoutBillAndAmountScreen> createState() =>
      _PaymentWithoutBillAndAmountScreenState();
}

double amount = 0.0;

class _PaymentWithoutBillAndAmountScreenState
    extends State<PaymentWithoutBillAndAmountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
            child: Text(
          'Bayar Tanpa Bil dan Amount',
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
            SizedBox(height: 20),
            TextFormField(
              initialValue: amount.toString(),
              autocorrect: false,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: styles.inputDecoration.copyWith(
                label: getRequiredLabel('Jumlah Bayaran'),
                prefixIcon:
                    Padding(padding: EdgeInsets.all(15), child: Text('RM')),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Sila masukkan jumlah bayran';
                }
                return null;
              },
              onChanged: (val) {
                setState(() {
                  amount = val as double;
                  print(amount);
                });
              },
            ),
            SizedBox(height: 30),
            PrimaryButton(
              onPressed: () {
                confirmPayment(context, amount, '01', [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                            text: 'Bayar RM' + amount.toString() + '?',
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
          ],
        ),
      ),
    );
  }
}
