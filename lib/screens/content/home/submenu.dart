import 'package:flutter/material.dart';
import 'package:flutterbase/components/curve_appbar.dart';
import 'package:flutterbase/components/loading_indicator.dart';
import 'package:flutterbase/controller/submenu_controller.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/screens/content/home/service.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class SubmenuScreen extends StatelessWidget {
  final controller = Get.put(SubmenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf9f9f9),
      appBar: CurveAppBar(
        title: "Servis Perkhidmatan",
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios,
            color: constants.primaryColor,
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            var homeRoute =
                MaterialPageRoute(builder: (_) => const MenuScreen());
            Navigator.of(context)
                .pushAndRemoveUntil(homeRoute, (route) => false);
          },
          icon: Icon(
            LineIcons.times,
            color: constants.primaryColor,
            size: 28,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            alignment: Alignment.centerLeft,
            child: Obx(
              () => Text(
                controller.title.value,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            alignment: Alignment.centerLeft,
            child: Text(
              "Senarai ${controller.title}",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            height: 50,
            child: TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              decoration: styles.inputDecoration.copyWith(
                labelText: 'Carian',
                prefixIcon: LineIcon(Icons.search),
              ),
            ),
          ),
          Obx(
            () => controller.isLoading.value
                ? const Center(child: LoadingIndicator())
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(20),
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 9,
                    crossAxisSpacing: 10,
                    children: [
                      for (var item in controller.submenus)
                        InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () =>
                              Get.to(() => ServicePage(), arguments: item),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/dist/submenu_icon.png',
                                  width: 65,
                                  height: 65,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
          )
        ],
      ),
    );
  }
}
