import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:tetris/screens/profile.dart';

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext contex) => Container(
        height: 350,
        decoration: BoxDecoration(
            color: Colors.redAccent,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(
                  'assets/sad.png',
                  height: 120,
                  width: 120,
                ),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Tetris Ligi Katılımı",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, left: 16.0),
              child: Text(
                "Tetris ligi sıralamalarına girebilmeniz için üye olmanız gerekmektedir.",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                myButton("Üye olma", () {
                  Navigator.of(contex).pop();
                }, Colors.grey, Colors.blue),
                SizedBox(width: 8),
                myButton("Kayıt ol", () {
                  Get.to(Profile());
                }, Colors.green, Colors.green),
              ],
            )
          ],
        ),
      );

  Widget myButton(String buttonText, onPressed, Color primary, Color surface) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(buttonText,
              style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )),
        ],
      ),
      style: ElevatedButton.styleFrom(
        primary: primary,
        onPrimary: surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
    );
  }
}
