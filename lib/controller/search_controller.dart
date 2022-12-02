import 'package:flutter/material.dart';
import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/search/search.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  final TextEditingController searchText = TextEditingController();

  RxList<SearchService> results = <SearchService>[].obs;
  RxList<SearchService> showResults = <SearchService>[].obs;
  // RxList<Menu> types = <Menu>[].obs;
  RxString controllerText = ''.obs;
  RxBool isLoading = false.obs;
  RxList<DropdownMenuItem<Menu>> menus = <DropdownMenuItem<Menu>>[].obs;
  Rx<Menu> selectedMenu = Menu(id: 0, menuTitle: "menuTitle").obs;
  @override
  void onInit() async {
    super.onInit();
    searchService();
  }

  onServiceChange(Menu? menu) {
    selectedMenu.value = menu!;
    showResults.value = results.where((p0) => p0.menuId == menu.id).toList();
  }

  searchService() {
    searchText.addListener(() {
      controllerText.value = searchText.text;
    });

    debounce(controllerText, (value) async {
      ErrorResponse response = await api.searchService(controllerText.value);
      isLoading(false);
      results.value = [];
      if (response.isSuccessful) {
        List<dynamic> parsed = response.data as List<dynamic>;
        results.value = parsed.map((e) => SearchService.fromJson(e)).toList();
        showResults.value =
            parsed.map((e) => SearchService.fromJson(e)).toList();
        List<Menu> _menus = results.map((element) => element.menu).toList();
        Map<String, Menu> mp = {};
        for (var item in _menus) {
          mp[item.menuTitle] = item;
        }
        menus.value = mp.values
            .toList()
            .map((e) =>
                DropdownMenuItem<Menu>(child: Text(e.menuTitle), value: e))
            .toList();
        selectedMenu.value = Menu(id: 0, menuTitle: "menuTitle");
      } else {
        print(response.message);
      }
    }, time: 1.seconds);
  }
}
