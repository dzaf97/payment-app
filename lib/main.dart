import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterbase/payments/bills/bill_without_amount/bill_without_amount.dart';
import 'package:flutterbase/payments/bills/payment_without_bill/payment_without_bill_sale_animal.dart';
import 'package:flutterbase/payments/bills/payment_without_bill/payment_without_bill_sale_book.dart';
import 'package:flutterbase/payments/bills/payment_without_bill/payment_without_bill_toursim.dart';
import 'package:flutterbase/payments/bills/payment_without_bill_and_amount/payment_without_bill_and_amount.dart';
import 'package:flutterbase/payments/bills/rateless_payment/rateless_payment.dart';
import 'package:flutterbase/payments/bills/single_multiple_bill/single_bill.dart';
import 'package:flutterbase/screens/onboarding/splash.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/route_manager.dart';

void main() async {
  debugPaintSizeEnabled = false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: constants.appName,
      theme: ThemeData(
        appBarTheme: AppBarTheme.of(context).copyWith(
          elevation: 0,
          color: constants.primaryColor,
          titleTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontFamily: 'SfProDisplayRegular'),
          iconTheme: const IconThemeData(opacity: 0.4),
        ),
        primarySwatch: constants.primaryColor,
        scaffoldBackgroundColor: const Color(0xffffffff),
      ),
      home: SplashScreen(),
      routes: {
        'bill': (context) => const SingleBillScreen(),
        'bill_without_amount': (context) => const BillWithoutAmountScreen(),
        'payment_without_bill_tourism': (context) =>
            const PaymentWithoutBillTourismScreen(),
        'payment_without_bill_sale_book': (context) =>
            const PaymentWithoutBillSaleBookScreen(),
        'payment_without_bill_sale_animal': (context) =>
            const PaymentWithoutBillSaleAnimalScreen(),
        'payment_without_bill_and_amount': (context) =>
            const PaymentWithoutBillAndAmountScreen(),
        'rateless_payment': (context) => const RatelessPaymentScreen(),
      },
    );
  }
}
