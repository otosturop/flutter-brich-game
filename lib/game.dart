import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tetris/block.dart';
import 'package:tetris/sub_block.dart';
import 'package:tetris/controllers/tetris_controller.dart';

enum Collision { LANDED, LANDED_BLOCK, HIT_WALL, HIT_BLOCK, NONE }

const BLOCK_X = 10;
const BLOCK_Y = 20;
const REFRESH_RATE = 300;
const GAME_AREA_BORDER_WIDTH = 2.0;
const SUB_BLOCK_EDGE_WIDTH = 2.0;

class Game extends StatefulWidget {
  Game({Key? key}) : super(key: key);

  @override
  GameState createState() => GameState();
}

class GameState extends State<Game> {
  bool isGameOver = false;
  late double subBlockWidth;
  Duration duration = Duration(milliseconds: REFRESH_RATE);
  GlobalKey _keyGameArea = GlobalKey();
  final TetrisController tetrisController = Get.put(TetrisController());

  BlockMovement? action;
  Block? block;
  Timer? timer;

  List<SubBlock>? oldSubBlocks;

  Block getNewBlock() {
    int blockType = Random().nextInt(7);
    int orientationIndex = Random().nextInt(4);

    switch (blockType) {
      case 0:
        return IBlock(orientationIndex);
      case 1:
        return JBlock(orientationIndex);
      case 2:
        return LBlock(orientationIndex);
      case 3:
        return OBlock(orientationIndex);
      case 4:
        return TBlock(orientationIndex);
      case 5:
        return SBlock(orientationIndex);
      case 6:
        return ZBlock(orientationIndex);
      default:
        return ZBlock(orientationIndex);
    }
  }

  void startGame() {
    isGameOver = false;
    tetrisController.setIsPlaying(true);
    oldSubBlocks = <SubBlock>[];
    tetrisController.resetScore();

    RenderBox? renderBoxGame =
        _keyGameArea.currentContext!.findRenderObject() as RenderBox?;
    subBlockWidth =
        (renderBoxGame!.size.width - GAME_AREA_BORDER_WIDTH * 2) / BLOCK_X;

    tetrisController.setNextBlock(getNewBlock());
    block = getNewBlock();

    timer = Timer.periodic(duration, onPlay);
  }

  void endGame() {
    tetrisController.setIsPlaying(false);
    timer?.cancel();
  }

  void onPlay(Timer time) {
    var status = Collision.NONE;
    if (this.mounted) {
      setState(() {
        if (action != null) {
          if (!checkOnEdge(action!)) {
            block?.move(action!);
          }
        }

        //Çevirme sırasında taşma sorunu çözümü
        if (action == BlockMovement.ROTATE_COUNTER_CLOCKWISE) {
          if (block!.x! + block!.width > BLOCK_X) {
            num difference = (block!.x! + block!.width) - BLOCK_X;
            for (int i = 0; i < difference; i++) {
              block!.move(BlockMovement.LEFT);
            }
          }
          //Zeminde Çevirme sırasında taşma sorunu çözümü
          if (block!.y! + block!.height > BLOCK_Y) {
            num diff = (block!.y! + block!.height) - BLOCK_Y;
            for (int x = 0; x < diff; x++) {
              block!.move(BlockMovement.UP);
            }
          }
        }
        // Zeminde iteleme durumu alt taşma sorunu çözümü
        if (action == BlockMovement.DOWN) {
          if (block!.y! + block!.height > BLOCK_Y) {
            num plusDif = (block!.y! + block!.height) - BLOCK_Y;
            for (int z = 0; z < plusDif; z++) {
              block!.move(BlockMovement.UP);
            }
          }
        }

        //Reverse action if the block hits other block
        for (var oldSubBlock in oldSubBlocks!) {
          for (var subBlock in block!.subBlocks) {
            var x = block!.x! + subBlock.x;
            var y = block!.y! + subBlock.y;
            if (x == oldSubBlock.x && y == oldSubBlock.y) {
              switch (action) {
                case BlockMovement.LEFT:
                  block!.move(BlockMovement.RIGHT);
                  break;
                case BlockMovement.RIGHT:
                  block!.move(BlockMovement.LEFT);
                  break;
                case BlockMovement.ROTATE_CLOCKWISE:
                  block!.move(BlockMovement.ROTATE_COUNTER_CLOCKWISE);
                  break;
                default:
                  break;
              }
            }
          }
        }

        if (!checkAtBottom()) {
          // kontrol zemİn
          if (!checkAboveBlock()) {
            // kontrol altındaki block
            block?.move(BlockMovement.DOWN);
          } else {
            status = Collision.LANDED_BLOCK;
          }
        } else {
          status = Collision.LANDED;
        }

        if (status == Collision.LANDED_BLOCK && block!.y! < 0) {
          isGameOver = true;
          endGame();
        } else if (status == Collision.LANDED ||
            status == Collision.LANDED_BLOCK) {
          block!.subBlocks.forEach((subBlock) {
            subBlock.x += block!.x;
            subBlock.y += block!.y;

            oldSubBlocks!.add(subBlock);
          });

          block = tetrisController.nextBlock;
          tetrisController.setNextBlock(getNewBlock());
          tetrisController.setIsNewBlock();
        }
        action = null;
        updateScore();
      });
    }
  }

  void updateScore() {
    var combo = 1;
    Map<int, int> rows = Map();
    List<int> rowsToBeRemoved = [];

    //count number of sub-blocks in each row
    oldSubBlocks?.forEach((subBlock) {
      rows.update(subBlock.y, (value) => ++value, ifAbsent: () => 1);
    });

    // Add score if a full row is found
    rows.forEach((rowNum, count) {
      if (count == BLOCK_X) {
        tetrisController.setScore(combo++);
        rowsToBeRemoved.add(rowNum);
      }
    });

    if (rowsToBeRemoved.length > 0) {
      removeRows(rowsToBeRemoved);
    }
  }

  void removeRows(List<int> rowsToBeRemoved) {
    rowsToBeRemoved.sort();
    rowsToBeRemoved.forEach((rowNum) {
      oldSubBlocks!.removeWhere((subBlock) => subBlock.y == rowNum);
      oldSubBlocks!.forEach((subBlock) {
        if (subBlock.y < rowNum) {
          ++subBlock.y;
        }
      });
    });
  }

  bool checkAtBottom() {
    return block!.y! + block!.height == BLOCK_Y;
  }

  bool checkAboveBlock() {
    for (var oldSubBlock in oldSubBlocks!) {
      for (var subBlock in block!.subBlocks) {
        var x = block!.x! + subBlock.x;
        var y = block!.y! + subBlock.y;
        if (x == oldSubBlock.x && y + 1 == oldSubBlock.y) {
          return true;
        }
      }
    }
    return false;
  }

  //kenarları kontrol etme
  bool checkOnEdge(BlockMovement action) {
    return (action == BlockMovement.LEFT && block!.x! <= 0) ||
        (action == BlockMovement.RIGHT && block!.x! + block!.width! >= BLOCK_X);
  }

  Positioned getPositionedSquareContainer(Color color, int x, int y) {
    return Positioned(
        left: x * subBlockWidth,
        top: y * subBlockWidth,
        child: Container(
          width: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
          height: subBlockWidth - SUB_BLOCK_EDGE_WIDTH,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(3.0)),
          ),
        ));
  }

  drawBloks() {
    if (block == null) return null;
    List<Positioned> subBlocks = [];

    block?.subBlocks.forEach((subBlock) {
      subBlocks.add(getPositionedSquareContainer(
          subBlock.color, subBlock.x + block?.x, subBlock.y + block?.y));
    });

    //old sub-bloks
    oldSubBlocks?.forEach((oldSubBlock) {
      subBlocks.add(getPositionedSquareContainer(
          oldSubBlock.color as Color, oldSubBlock.x, oldSubBlock.y));
    });

    if (isGameOver) {
      subBlocks.add(getGameOverRect());
    }

    return Stack(children: subBlocks);
  }

  Positioned getGameOverRect() {
    return Positioned(
      child: Container(
        width: subBlockWidth * 8.0,
        height: subBlockWidth * 3.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Text(
          'Game Over',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      left: subBlockWidth * 1.0,
      top: subBlockWidth * 6.0,
    );
  }

  void changeBlockMove(int state) {
    if (state == 1) {
      action = BlockMovement.LEFT;
    } else if (state == 0) {
      action = BlockMovement.ROTATE_COUNTER_CLOCKWISE;
    } else if (state == 2) {
      action = BlockMovement.RIGHT;
    } else if (state == 3) {
      if (!checkAboveBlock()) {
        action = BlockMovement.DOWN;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.delta.dx > 0) {
          action = BlockMovement.RIGHT;
        } else {
          action = BlockMovement.LEFT;
        }
      },
      onTap: () {
        action = BlockMovement.ROTATE_COUNTER_CLOCKWISE;
      },
      child: AspectRatio(
        aspectRatio: BLOCK_X / BLOCK_Y,
        child: Container(
          key: _keyGameArea,
          decoration: BoxDecoration(
              color: Colors.indigo[800],
              border: Border.all(
                  width: GAME_AREA_BORDER_WIDTH, color: Colors.indigoAccent),
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: drawBloks(),
        ),
      ),
    );
  }
}
