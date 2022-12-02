import 'package:flutter/widgets.dart';
import 'package:flutterbase/models/contents/menu.dart';
import 'package:flutterbase/models/users/user.dart';
import 'package:flutterbase/states/menu_state.dart';
import 'package:flutterbase/states/user_state.dart';

class AppDataState {
  UserState userState = UserState(UserDataState());
  MenuState menuState = MenuState(MenuDataState());
}

class AppState extends ValueNotifier<AppDataState> {
  AppState(AppDataState value) : super(value);
  User get user => value.userState.value.data;
  List<Menu> get menus => value.menuState.value.data;

  void clear() {
    value.userState.clear();
    value.menuState.clear();
    notifyListeners();
  }

  void resume() {}

  void setUser(User data) {
    value.userState.set(data);
    notifyListeners();
  }

  void setMenu(List<Menu> data) async {
    value.menuState.set(data);
    notifyListeners();
  }
}

AppState state = AppState(AppDataState());
