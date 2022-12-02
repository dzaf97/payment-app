import 'package:flutterbase/api/api.dart';
import 'package:flutterbase/models/contents/menu.dart';
import 'package:get/get.dart';

class SubmenuController extends GetxController {
  RxString title = "".obs;
  RxList<Menu> submenus = <Menu>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() async {
    await setup();
    super.onInit();
  }

  Future<void> setup() async {
    Menu menu = Get.arguments as Menu;
    title.value = menu.name;
    isLoading(true);
    submenus.value = await api.getSubmenu(menu.id);
    isLoading(false);
  }
}
