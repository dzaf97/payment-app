import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutterbase/components/loading_indicator.dart';
import 'package:flutterbase/controller/search_controller.dart';
import 'package:flutterbase/models/search/search.dart';
import 'package:flutterbase/screens/content/home/product.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';

class Search extends StatelessWidget {
  final controller = Get.put(SearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppBar().preferredSize.height),
        child: Hero(
          tag: "search",
          child: AppBar(
            backgroundColor: Colors.white,
            title: TextField(
              controller: controller.searchText,
              decoration: InputDecoration(border: InputBorder.none),
              onChanged: (value) => controller.isLoading(true),
            ),
            elevation: 1,
          ),
        ),
      ),
      body: Obx(
        () {
          List<Widget> resultWidgets = [];
          resultWidgets.addAll(
            controller.showResults.map(
              (e) => ListTile(
                leading: CircleAvatar(
                  child: Text((e.serviceTitle.split(" ").length > 2)
                      ? e.serviceTitle.split(" ").first[0] +
                          e.serviceTitle.split(" ")[1][0]
                      : e.serviceTitle[0].capitalize!),
                ),
                title: Text(e.serviceTitle),
                subtitle: Text(e.menu.menuTitle),
                onTap: () => Get.to(() => Product(), arguments: e.id),
              ),
            ),
          );

          return (controller.isLoading.value)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingIndicator(),
                      SizedBox(height: Get.height * 0.2)
                    ],
                  ),
                )
              : controller.results.isEmpty
                  ? Center(
                      child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/dist/not_found.jpg',
                          scale: 8,
                        ),
                        Text("Result not found!",
                            style: TextStyle(fontSize: 18)),
                        SizedBox(height: Get.height * 0.2)
                      ],
                    ))
                  : ListView(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Container(
                              height: 30,
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: constants.primaryColor),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Obx(
                                () => DropdownButton<Menu>(
                                  items: controller.menus,
                                  underline: Container(),
                                  onChanged: controller.onServiceChange,
                                  hint: Text(
                                    (controller.selectedMenu.value.id == 0
                                        ? "Jenis Perkhidmatan"
                                        : controller
                                            .selectedMenu.value.menuTitle),
                                  ),
                                  // value: controller.selectedMenu?.value,
                                ),
                              ),
                            )
                          ],
                        ),
                        ...resultWidgets,
                      ],
                    );
        },
      ),
    );
  }
}
