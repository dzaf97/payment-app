import 'package:flutter/material.dart';
import 'package:flutterbase/utils/constants.dart';

class PrimaryButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final bool isLoading;

  const PrimaryButton({
    Key? key,
    this.onPressed,
    required this.text,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Constants().sixColor,
        minimumSize: const Size(300, 60),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const CircularProgressIndicator()
          : SizedBox(
              width: double.infinity,
              child: Text(
                text.toUpperCase(),
                style: styles.raisedButtonTextWhite,
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
