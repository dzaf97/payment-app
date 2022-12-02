import 'package:flutter/material.dart';
import 'package:flutterbase/models/contents/menu.dart';

class MenuDataState {
  List<Menu> data = [];
}

class MenuState extends ValueNotifier<MenuDataState> {
  MenuState(MenuDataState value) : super(value);

  void clear() {
    value.data = [];
    notifyListeners();
  }

  void set(List<Menu> data) {
    value.data = data;
    notifyListeners();
  }
}
