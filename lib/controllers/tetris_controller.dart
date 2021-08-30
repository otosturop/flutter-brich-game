import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tetris/block.dart';
import 'package:tetris/data/tetris_api.dart';
import 'package:tetris/models/TetrisModel.dart';

class TetrisController extends GetxController {
  var score = 0.obs;
  var isPlaying = false.obs;
  var isUser = false.obs;
  Block? nextBlock;
  var isNewBlock = false.obs;
  TetrisApi _tetrisApi = TetrisApi();
  var userId = "".obs;

  void setScore(int point) => score.value += point;

  void setIsPlaying(bool state) => isPlaying.value = state;

  void resetScore() => score.value = 0;

  void setNextBlock(Block nextBlock) => this.nextBlock = nextBlock;

  void setIsNewBlock() => isNewBlock.value = !isNewBlock.value;

  @override
  void onInit() {
    getUserId();
    print("tetris oninit: " + isUser.value.toString());
    super.onInit();
  }

  Future<void> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('userId')) {
      isUser.value = true;
      userId.value = prefs.getString("userId") ?? "0";
    } else
      isUser.value = false;
  }

  void gameOver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("userId")) {
      if (!prefs.containsKey('score')) {
        prefs.setInt('score', score.value);
      } else {
        int? memoryScore = prefs.getInt('score');
        if (memoryScore! < score.value) {
          var newScore = await updateScore();
          print("top update:" + newScore.toString());
          prefs.setInt('score', score.value);
        }
      }
    } else {
      print("user yok");
    }
  }

  Future<TetrisModel?> updateScore() async {
    return await _tetrisApi.updateTetrisPoint(
        userId.value, score.value.toString());
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
