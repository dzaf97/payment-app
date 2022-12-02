import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';

class PlaceholderNotificationScreen extends StatelessWidget {
  const PlaceholderNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const curveHeight = -20.0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        shape: const MyShapeBorder(curveHeight),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage('assets/dist/dummy_notifikasi.jpg'),
                fit: BoxFit.fitWidth),
          ),
        ),
      ),
    );
  }
}
