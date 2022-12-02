import 'package:flutter/material.dart';
import 'package:flutterbase/components/primary_button.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class SearchBillScreen extends StatefulWidget {
  const SearchBillScreen({Key? key}) : super(key: key);

  @override
  State<SearchBillScreen> createState() => _SearchBillScreenState();
}

class _SearchBillScreenState extends State<SearchBillScreen> {
  bool _isFavourite = true;
  bool _isVisibileBtn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Center(
            child: Column(
          children: [
            Text('Carian Bil', style: styles.heading1sub),
          ],
        )),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(LineIcons.times),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 220,
                          color: constants.primaryColor,
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              Text('Yuran Pengajian',
                                  style: styles.heading17white),
                              SizedBox(height: 5),
                              Text('Yuran PIBG SMK Alor Akar Kuantan',
                                  style: styles.heading8subWhite),
                              SizedBox(height: 20),
                              Text('Sila masukkan nombor Mykad pelajar',
                                  style: styles.heading2white),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 16, 16, 0),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  decoration: styles.inputDecoration.copyWith(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '931126XXXXXX',
                                      suffixIcon: LineIcon(Icons.search)),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Sila masukkan nombor telefon';
                                    }
                                    return null;
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      _isVisibileBtn = true;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Akaun Kegemaran'),
                              Row(
                                children: [
                                  Icon(
                                    LineIcons.plusCircle,
                                    color: constants.primaryColor,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    'Tambah',
                                    style: styles.heading6bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: _isFavourite,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Card(
                                  elevation: 2,
                                  color: Color(0xFFF5F6F9),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(8),
                                    onTap: () {
                                      // navigate(context, SearchBillScreen());
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Akaun saya',
                                                style: styles.heading16),
                                            SizedBox(height: 10),
                                            Text('931176285967',
                                                style: styles.heading2),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: _isVisibileBtn,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: PrimaryButton(
                    onPressed: () {
                      // Buat Carian
                    },
                    text: 'Semak',
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
