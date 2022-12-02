import 'package:flutter/material.dart';
import 'package:flutterbase/screens/content/home/menu.dart';
import 'package:flutterbase/utils/constants.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class CurveAppBar extends StatelessWidget implements PreferredSizeWidget {
  CurveAppBar({
    required this.title,
    required this.leading,
    required this.trailing,
  });
  final Widget leading;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Material(
          color: constants.primaryColor,
          shape: MyShapeBorder2(-35),
          child: Container(
            height: 120,
          ),
        ),
        Positioned.fill(
          top: 65,
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: leading,
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: styles.heading5,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: trailing,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}

class MyShapeBorder2 extends ContinuousRectangleBorder {
  const MyShapeBorder2(this.curveHeight);
  final double curveHeight;

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) => Path()
    ..lineTo(0, rect.size.height - 40)
    ..quadraticBezierTo(
      rect.size.width / 2,
      rect.size.height + curveHeight * 2,
      rect.size.width,
      rect.size.height / 1.6,
    )
    ..lineTo(rect.size.width, 0)
    ..close();
}
