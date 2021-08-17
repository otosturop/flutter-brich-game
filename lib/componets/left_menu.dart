import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/screens/arrangement.dart';
import 'package:tetris/screens/home.dart';
import 'package:tetris/screens/profile.dart';
import 'package:tetris/screens/tetris.dart';

class LeftMenu extends StatelessWidget {
  const LeftMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE26NjQaonqTRt7BXD_87Iuukitk_kcGBv3w&usqp=CAU")))),
          ),
          Spacer(),
          Expanded(
            flex: 2,
            child: menuButton(
                'Anasayfa', Colors.redAccent, Colors.redAccent.shade700, () {
              Get.to(() => Home());
            }),
          ),
          Expanded(
            flex: 2,
            child: menuButton(
                'Profile', Colors.blueAccent, Colors.blue.shade900, () {
              Get.to(() => Profile());
            }),
          ),
          Expanded(
            flex: 2,
            child: menuButton(
                'Sıralamalar', Colors.orange, Colors.yellow.shade700, () {
              Get.to(() => Arragement());
            }),
          ),
          Expanded(
            flex: 2,
            child: menuButton('Tetris', Colors.purple, Colors.orange, () {
              Get.to(() => Tetris());
            }),
          ),
          Expanded(
            flex: 2,
            child:
                menuButton('Ödül Al', Colors.greenAccent, Colors.orange, () {}),
          ),
          Spacer(
            flex: 2,
          ),
          Spacer(
            flex: 2,
          ),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }

  Widget menuButton(
      String buttonText, Color mainColor, Color secondColor, onPressed) {
    return Center(
        child: Container(
      width: Get.width * 0.3,
      height: Get.height * 0.06,
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
                color: Colors.white,
              ),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: mainColor,
          onPrimary: secondColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
        ),
      ),
    ));
  }
}
