import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class DefaultButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const DefaultButton({Key? key, this.onPressed, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: constants.secondaryColor,
        minimumSize: const Size(300, 60),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: double.infinity,
        child: Text(
          text.toUpperCase(),
          style: styles.heading10bold,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
