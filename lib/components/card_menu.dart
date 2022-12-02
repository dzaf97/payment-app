import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class CardMenu extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData icon;
  final Color color;

  const CardMenu({
    Key? key,
    this.onPressed,
    required this.text,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          // switch (item.type) {
          //   case 'Menu':
          //     navigate(context, SubmenuScreen(item));
          //     break;
          // }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(height: 5),
              Text(
                text,
                maxLines: 2,
                style: styles.heading11,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
