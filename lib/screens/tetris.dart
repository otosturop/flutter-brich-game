import 'package:flutter/material.dart';
import 'package:tetris/block.dart';
import 'package:tetris/game.dart';
import 'package:tetris/componets/next_block.dart';
import 'package:tetris/componets/score_bar.dart';
import 'package:tetris/controllers/tetris_controller.dart';
import 'package:get/get.dart';
import 'package:tetris/helper/dialog_helper.dart';

class Tetris extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  GlobalKey<GameState> _keyGame = GlobalKey();
  final TetrisController tetrisController = Get.put(TetrisController());
  BlockMovement? action;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tetris'),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: Column(
          children: [
            ScoreBar(),
            Expanded(
                child: Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                      child: Game(key: _keyGame),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5.0, 10.0, 10.0, 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Obx(() {
                            if (tetrisController.isNewBlock.value) {
                              return NextBlock();
                            } else {
                              return NextBlock();
                            }
                          }),
                          SizedBox(height: 30.0),
                          Obx(() {
                            return ElevatedButton(
                              onPressed: () {
                                if (!tetrisController.isUser.value) {
                                  DialogHelper.exit(context);
                                } else {
                                  tetrisController.isPlaying.value
                                      ? _keyGame.currentState!.endGame()
                                      : _keyGame.currentState!.startGame();
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    tetrisController.isPlaying.value
                                        ? "End"
                                        : "Start",
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.grey[200]),
                                  ),
                                ],
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.indigo[700],
                                onPrimary: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.all(0),
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_left_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 56.0,
                    onPressed: () {
                      _keyGame.currentState!.changeBlockMove(1);
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_right_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 56.0,
                    onPressed: () {
                      if (this.mounted) {
                        setState(() {
                          _keyGame.currentState!.changeBlockMove(2);
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.white,
                    ),
                    iconSize: 56.0,
                    onPressed: () {
                      if (this.mounted) {
                        setState(() {
                          _keyGame.currentState!.changeBlockMove(3);
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.autorenew),
                    color: Colors.white,
                    iconSize: 48.0,
                    onPressed: () {
                      if (this.mounted) {
                        setState(() {
                          _keyGame.currentState!.changeBlockMove(0);
                        });
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
