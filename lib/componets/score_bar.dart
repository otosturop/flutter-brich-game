import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/controllers/tetris_controller.dart';

class ScoreBar extends StatelessWidget {
  ScoreBar({Key? key}) : super(key: key);
  final TetrisController tetrisController = Get.put(TetrisController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xFF383593), Color(0xFF3F51B5)])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Obx(() {
              return Text(
                'Score: ${tetrisController.score.value.toString()}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              );
            }),
          ),
        ],
      ),
    );
  }
}
