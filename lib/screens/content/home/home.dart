import 'package:flutter/material.dart';
import 'package:flutterbase/screens/content/search/search.dart';
import 'package:flutterbase/utils/helpers.dart';
import 'package:flutterbase/components/appbar_header.dart';
import 'package:flutterbase/screens/content/bill/search_bill.dart';
import 'package:flutterbase/screens/content/home/submenu.dart';
import 'package:flutterbase/states/app_state.dart';
import 'package:flutterbase/states/menu_state.dart';
import 'package:flutterbase/states/user_state.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    const curveHeight = -20.0;
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: AppBar(
        shape: const MyShapeBorder(curveHeight),
        automaticallyImplyLeading: false,
      ), //AppB
      body: SafeArea(
        child: ListView(
          children: [
            Heading(),
            User(),

            // BannerCarousel(),
            // HighlightGrid(),
            // ArticleCarousel(),
            // Footer(),
          ],
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
      child: ValueListenableBuilder(
        valueListenable: state.value.userState,
        builder: (BuildContext context, UserDataState value, Widget? child) {
          return Row(
            children: [
              SizedBox(
                height: 54,
                width: 54,
                child: Stack(
                  children: [
                    Container(
                      decoration: (state.user.avatarUrl != '')
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(state.user.avatarUrl!),
                              ),
                            )
                          : null,
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(27),
                        onTap: () {
                          DefaultTabController.of(context)?.animateTo(3);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Center(
                  child: Text('Utama',
                      style: GoogleFonts.openSans(
                          fontSize: 20, fontWeight: FontWeight.w600)),
                ),
              ),
              Icon(
                LineIcons.addToShoppingCart,
                color: Constants().primaryColor,
                size: 35,
              )
            ],
          );
        },
      ),
    );
  }
}

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(22, 30, 22, 15),
      child: ValueListenableBuilder(
        valueListenable: state.value.userState,
        builder: (BuildContext context, UserDataState value, Widget? child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selamat Datang !', style: styles.heading9),
              Text(state.user.firstName!, style: styles.heading2),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => Get.to(
                  () => Search(),
                  duration: Duration(milliseconds: 400),
                  transition: Transition.fadeIn,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Hero(
                    tag: "search",
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 13),
                        Text(
                          "Carian",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // TextFormField(
              //   textInputAction: TextInputAction.next,
              //   keyboardType: TextInputType.number,
              //   decoration: styles.inputDecoration.copyWith(
              //       labelText: 'Carian', prefixIcon: LineIcon(Icons.search)),
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Sila masukkan nombor telefon';
              //     }
              //     return null;
              //   },
              //   onChanged: (val) {
              //     setState(() {
              //       _isSearching = true;
              //     });
              //   },
              // ),
              SizedBox(height: 20),
              Visibility(
                visible: _isSearching,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hasil Carian (1)'),
                    SizedBox(height: 5),
                    Card(
                      elevation: 2,
                      color: Color(0xFFF5F6F9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () {
                          navigate(context, SearchBillScreen());
                        },
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: (state.user.avatarUrl != '')
                                            ? BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      state.user.avatarUrl!),
                                                ),
                                              )
                                            : null,
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(27),
                                          onTap: () {
                                            DefaultTabController.of(context)
                                                ?.animateTo(3);
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                      'Yuran PIBG SMK Alor Akar Kuantan',
                                      style: styles.heading16),
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset('assets/dist/home_header_cut.jpg'),
              ),
              SizedBox(height: 20),
              MainMenu(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Servis Kegemaran (3)",
                    style: AppStyles().heading12sub,
                  ),
                  Text(
                    "Lihat semua",
                    style: TextStyle(color: constants.primaryColor, height: 2),
                  ),
                ],
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 260,
                ),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 10),
                      ListTile(
                        isThreeLine: false,
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFE2EFE8),
                          child: Text(
                            "AS",
                            style: TextStyle(color: Color(0xFF8C9791)),
                          ),
                        ),
                        title: Text(
                          "Yuran PIBG SMK Alor Akar Kuantan",
                          style: TextStyle(color: Color(0xFF282B29)),
                        ),
                      ),
                      Divider(thickness: 1.2, indent: 10, endIndent: 10),
                      ListTile(
                        tileColor: Colors.white,
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFE2EFE8),
                          child: Text(
                            "AS",
                            style: TextStyle(color: Color(0xFF8C9791)),
                          ),
                        ),
                        title: Text(
                          "Yuran PIBG",
                          style: TextStyle(color: Color(0xFF282B29)),
                        ),
                      ),
                      Divider(thickness: 1.2, indent: 10, endIndent: 10),
                      ListTile(
                        tileColor: Colors.white,
                        leading: CircleAvatar(
                          backgroundColor: Color(0xFFE2EFE8),
                          child: Text(
                            "AS",
                            style: TextStyle(color: Color(0xFF8C9791)),
                          ),
                        ),
                        title: Text(
                          "Yuran PIBG",
                          style: TextStyle(color: Color(0xFF282B29)),
                        ),
                      ),
                      Divider(thickness: 1.2, indent: 10, endIndent: 10),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset('assets/dist/home_menu_anoucement.jpg'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: state.value.menuState,
      builder: (BuildContext context, MenuDataState value, Widget? child) {
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          crossAxisCount: 4,
          childAspectRatio: 1,
          mainAxisSpacing: 0,
          crossAxisSpacing: 10,
          children: [
            for (var item in value.data)
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  switch (item.type) {
                    case 'Menu':
                      Get.to(() => SubmenuScreen(), arguments: item);
                      // navigate(context, SubmenuScreen(item));
                      break;
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/dist/home_menu_icon.png',
                      width: 45,
                      height: 45,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff333333),
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
