import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterScreen extends StatefulWidget {
  HelpCenterScreen({Key? key}) : super(key: key);

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            'Hubungi Kami',
            style: styles.heading1sub,
          ),
        ),
        body: Container(
            child: SafeArea(
                child: ListView(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 20),
                    children: [
              Text(
                'Perlukan Bantuan?',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 26),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Hubungi pasukan perkhidmatan pelanggan kami dengan cuma 1 langkah mudah.',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 13),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Tekan salah satu saluran dibawah dan laporkan aduan anda:',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/dist/inbox_fb.png'),
                            iconSize:
                                MediaQuery.of(context).size.height * 0.095,
                            onPressed: () {
                              launchUrl(Uri.parse("https://www.facebook.com/profile.php?id=100069340744120"));
                            },
                          ),
                          const Text(
                            "Inbox\nFacebook",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Column(
                          children: [
                            IconButton(
                              icon: Image.asset('assets/dist/call_us.png'),
                              iconSize:
                                  MediaQuery.of(context).size.height * 0.075,
                              onPressed: () {
                                launchUrl(Uri.parse("tel:0388824565"));
                              },
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              "Hubungi\n03-8882 4565",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w400),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Cawangan iPayment:',
                              style: styles.heading3,
                            )),
                        const SizedBox(height: 10),
                        Text(
                            "4th Floor, Podium Bangunan AICB, No. 10, Jalan Dato' Onn, 50480 Kuala Lumpur"),
                        const SizedBox(height: 20),
                        Image.asset('assets/dist/map.png'),
                      ],
                    ),
                  ),
                ],
              )
            ]))));
  }
}
