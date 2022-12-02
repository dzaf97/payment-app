import 'package:flutter/material.dart';
import 'package:flutterbase/utils/helpers.dart';

class AppStyles {
  TextStyle raisedButtonTextWhite = TextStyle(fontSize: 16.0, color: Colors.white, letterSpacing: 1);
  TextStyle heading1 = TextStyle(fontSize: 25, color: Colors.white);
  TextStyle heading1sub = TextStyle(fontSize: 16, color: Colors.white);
  TextStyle heading1sub2 = TextStyle(fontSize: 12, color: Colors.white);
  TextStyle heading2 = TextStyle(fontSize: 16, color: constants.eightColor);
  TextStyle heading2sub = TextStyle(fontSize: 16);
  TextStyle heading2white = TextStyle(fontSize: 16, color: Colors.white);
  TextStyle heading3 = TextStyle(fontSize: 16, color: constants.primaryColor);
  TextStyle heading3sub = TextStyle(fontSize: 14, color: constants.primaryColor);
  TextStyle heading4 = TextStyle(fontSize: 16, color: Colors.white);
  TextStyle heading5 = TextStyle(fontSize: 16, color: Colors.black);
  TextStyle heading5bold = TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle heading6 = TextStyle(fontSize: 16, color: constants.primaryColor);
  TextStyle heading6bold = TextStyle(fontSize: 16, color: constants.primaryColor, fontWeight: FontWeight.bold);
  TextStyle heading7 = TextStyle(fontSize: 16, color: constants.sixColor);
  TextStyle heading8 = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  TextStyle heading8sub = TextStyle(fontSize: 14);
  TextStyle heading8subWhite = TextStyle(fontSize: 14, color: Colors.white);
  TextStyle heading9 = TextStyle(fontSize: 20);
  TextStyle heading9bold = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle heading10 = TextStyle(fontSize: 14, color: Colors.black);
  TextStyle heading10bold = TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);
  TextStyle heading11 = TextStyle(fontSize: 12, color: Colors.black);
  TextStyle heading12bold = TextStyle(fontSize: 16, color: constants.primaryColor, fontWeight: FontWeight.bold);
  TextStyle heading12sub = TextStyle(fontSize: 18, color: Colors.black);
  TextStyle heading13 = TextStyle(fontSize: 18, color: constants.sixColor);
  TextStyle heading6boldYellow = TextStyle(fontSize: 16, color: constants.sixColor, fontWeight: FontWeight.bold);
  TextStyle heading14 = TextStyle(fontSize: 12, color: Colors.grey);
  TextStyle heading14sub = TextStyle(fontSize: 16, color: Colors.grey);
  TextStyle heading15 = TextStyle(fontSize: 16);
  TextStyle heading16 = TextStyle(fontSize: 16);
  TextStyle heading17 = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle heading17white = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white);
  TextStyle heading18 = TextStyle(fontSize: 14, color: constants.eightColor);
  TextStyle heading18grey = TextStyle(fontSize: 14);


  InputDecoration inputDecoration = InputDecoration(
    filled: false,
    fillColor: const Color(0xffF1F3F6),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(11),
      borderSide: const BorderSide(color: Color(0xffE7EAF0)),
    ),
  );
}

var styles = AppStyles();

class Constants {
  final String appName = 'pahangGO';
  final MaterialColor paleWhite = createMaterialColor(Color(0xFFFFFFFF));
  final MaterialColor nineColor = createMaterialColor(
    const Color(0xFFFFFFFF),
  );
  final MaterialColor eightColor = createMaterialColor(
    const Color(0xFFF8c9791),
  );
  final MaterialColor sevenColor = createMaterialColor(
    const Color(0xFFF282b29),
  );
  final MaterialColor sixColor = createMaterialColor(
    const Color(0xFFFebab50),
  );
  final MaterialColor fiveColor = createMaterialColor(
    const Color(0xFFFf6c16b),
  );
  final MaterialColor fourColor = createMaterialColor(
    const Color(0xFFFd0e7dc),
  );
  final MaterialColor thirdColor = createMaterialColor(
    const Color(0xFFF33a36d),
  );
  final MaterialColor secondaryColor = createMaterialColor(
    const Color(0xFFFd5e2e1),
  );
  final MaterialColor primaryColor = createMaterialColor(
    const Color(0xFFF045b62),
  );
  final MaterialColor splashColor = createMaterialColor(
    const Color(0xFFF06565d),
  );
  final MaterialColor loginText = createMaterialColor(Color(0xFF7A869A));
}

var constants = Constants();
