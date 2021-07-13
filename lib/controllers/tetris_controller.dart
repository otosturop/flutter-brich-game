import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/block.dart';

class TetrisController extends GetxController {
  var score = 0.obs;
  var isGameOver = false.obs;
  var isPlaying = false.obs;
  Block? nextBlock;
  var isNewBlock = false.obs;

  void setScore(int point) => score.value += point;

  void setIsPlaying(bool state) => isPlaying.value = state;

  void resetScore() => score.value = 0;

  void setNextBlock(Block nextBlock) => this.nextBlock = nextBlock;

  void setIsNewBlock() {
    isNewBlock.value = !isNewBlock.value;
  }

  Widget getNextBlockWidget() {
    if (!isPlaying.value) return Container();

    var width = nextBlock!.width;
    var height = nextBlock!.height;
    var color;

    List<Widget> colums = [];
    for (var y = 0; y < height; ++y) {
      List<Widget> rows = [];
      for (var x = 0; x < width; ++x) {
        if (nextBlock!.subBlocks
                .where((subBlock) => subBlock.x == x && subBlock.y == y)
                .length >
            0) {
          color = nextBlock!.color;
        } else {
          color = Colors.transparent;
        }
        rows.add(Container(width: 12, height: 12, color: color));
      }
      colums.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows,
      ));
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: colums,
    );
  }
}
