import 'package:flutter/material.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class PlaceholderHistoryScreen extends StatelessWidget {
  const PlaceholderHistoryScreen({Key? key}) : super(key: key);

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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(22, 10, 22, 0),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Sejarah Bayaran',
                              style: GoogleFonts.openSans(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 20),
                            ListTile(
                              onTap: () async {},
                              trailing: Icon(LineIcons.envelopeOpen),
                              title: Text(
                                'item.title',
                              ),
                              isThreeLine: true,
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'item.subtitle',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Divider(height: 2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
