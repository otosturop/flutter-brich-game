import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoundationButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const FoundationButton(this.buttonText, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: Get.width * 0.5,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(
                  fontFamily: 'Varela',
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).colorScheme.primary,
          onPrimary: Theme.of(context).colorScheme.surface,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    ));
  }
}
