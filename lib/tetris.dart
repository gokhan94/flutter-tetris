import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris/block/block.dart';
import 'package:tetris/score_counter.dart';
import 'package:tetris/tetremino/iblock.dart';
import 'package:tetris/tetremino/jblock.dart';
import 'package:tetris/tetremino/oblock.dart';
import 'package:tetris/tetremino/tblock.dart';
import 'package:tetris/tetremino/zblock.dart';
import 'block/sub_block.dart';

const GAME_AREA_BORDER = 2.0;
enum Collision { BOTTOM_LANDED, LANDED_BLOCK, WALL, HIT_BLOCK, NONE }
const int BOARD_WIDTH = 9;
const int BOARD_HEIGHT = 15;

class TetrisGame extends StatefulWidget {
  TetrisGame({Key key}) : super(key: key);
  @override
  TetrisGameState createState() => TetrisGameState();
}

class TetrisGameState extends State<TetrisGame> {
  static const screen_width = 320;
  static const screen_height = 600;

  BlockMovement action;
  Block block;
  Timer timer;
  List<SubBlock> previousSubBlocks;
  int score = 0;

  void gameStart() {
    Provider.of<Counter>(context, listen: false).setScore(score);
    previousSubBlocks = List<SubBlock>();
    block = newBlock();
    timer = Timer.periodic(Duration(milliseconds: 350), (timer) {
      playGame(timer);
      deleteFullRow();
    });
  }

  void playGame(timer) {
    var status = Collision.NONE;
    setState(() {
      // Block Direction
      if (action != null) {
        block.move(action);
      }

      // Are there any blocks colliding on the horizontal axis ?
      blockCheckHorizontal();

      if (!blockBottomCollision()) {
        if (!blockLandedCollision()) {
          block.move(BlockMovement.DOWN);
        } else {
          status = Collision.LANDED_BLOCK;
        }
      } else {
        status = Collision.BOTTOM_LANDED;
      }

      if (status == Collision.BOTTOM_LANDED ||
          status == Collision.LANDED_BLOCK) {
        // old subBlocks
        block.subBlocks.forEach((subBlock) {
          subBlock.x += block.x;
          subBlock.y += block.y;
          previousSubBlocks.add(subBlock);
        });

        // new generate block
        block = newBlock();
      }

      gameOver();

      action = null;
    });
  }

  void blockCheckHorizontal() {
    for (var oldSubBlock in previousSubBlocks) {
      for (var subBlock in block.subBlocks) {
        var x = block.x + subBlock.x;
        var y = block.y + subBlock.y;
        if (x == oldSubBlock.x && y == oldSubBlock.y) {
          switch (action) {
            case BlockMovement.LEFT:
              block.move(BlockMovement.RIGHT);
              break;
            case BlockMovement.RIGHT:
              block.move(BlockMovement.LEFT);
              break;
            case BlockMovement.ROTATE:
              block.move(BlockMovement.ROTATE);
              break;
            default:
              break;
          }
        }
      }
    }
  }

  void deleteRow(int rowIndex) {
    // max rowIndex 14
    setState(() {
      previousSubBlocks.removeWhere((subBlock) => subBlock.y == rowIndex);

      previousSubBlocks.forEach((subBlock) {
        if (subBlock.y < BOARD_HEIGHT) {
          subBlock.y++;
        }
      });

      Provider.of<Counter>(context, listen: false).scoreIncrement(score += 1);
    });
  }

  void deleteFullRow() {
    for (int row = 0; row < BOARD_HEIGHT; row++) {
      int counter = 0;
      previousSubBlocks.forEach((subBlock) {
        if (subBlock.y == row) {
          counter++;
        }
      });

      if (counter == BOARD_WIDTH) {
        deleteRow(row);
      }
    }
  }

  void gameOver() {
    previousSubBlocks.forEach((subBlock) {
      if (subBlock.y == 0) {
        timer.cancel();
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialog(context);
            });
      }
    });
  }

  Widget dialog(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      backgroundColor: Colors.white70,
      title: Text(
        "Game Over",
        style: TextStyle(
            fontSize: 26, color: Colors.indigo, fontWeight: FontWeight.bold),
      ),
      content: Text("Score : $score",
          style: TextStyle(fontSize: 24, color: Colors.indigo.shade900)),
      actions: [restartButton(context)],
    );
  }

  Widget restartButton(context) {
    return FlatButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      color: Colors.indigoAccent,
      child: Text(
        "Restart Game",
        style: TextStyle(
          fontSize: 20,
          color: Colors.white70,
        ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  void moveLeft() {
    if (block.x != 0) {
      action = BlockMovement.LEFT;
    }
  }

  void moveRight() {
    if (!(block.x + block.width > screen_width / 40)) {
      action = BlockMovement.RIGHT;
    }
  }

  void moveRotate() {
    if (!(block.x + block.width > screen_width / 40)) {
      action = BlockMovement.ROTATE;
    }
  }

  Block newBlock() {
    int blockType = Random().nextInt(5);
    int orientationIndex = Random().nextInt(4);

    switch (blockType) {
      case 0:
        return IBlock(orientationIndex);
        break;
      case 1:
        return JBlock(orientationIndex);
        break;
      case 2:
        return OBlock(orientationIndex);
        break;
      case 3:
        return TBlock(orientationIndex);
        break;
      case 4:
        return ZBlock(orientationIndex);
        break;
      default:
        return null;
    }
  }

  bool blockLandedCollision() {
    for (var oldSubBlock in previousSubBlocks) {
      for (var subBlock in block.subBlocks) {
        var x = block.x + subBlock.x;
        var y = block.y + subBlock.y;
        if (x == oldSubBlock.x && y + 1 == oldSubBlock.y) {
          return true;
        }
      }
    }
    return false;
  }

  bool blockBottomCollision() {
    return block.y + block.height == screen_height / 40;
  }

  Widget blockSquare(Color color, int x, int y) {
    return Positioned(
      left: x * 35.0,
      top: y * 35.0,
      child: Container(
        width: 35.0,
        height: 35.0,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
    );
  }

  Widget drawBlock() {
    if (block == null) return null;
    List<Positioned> subBlockPosition = List();

    block.subBlocks.forEach((subBlock) {
      subBlockPosition.add(blockSquare(
          subBlock.color, subBlock.x + block.x, subBlock.y + block.y));
    });

    // old subBlocks
    previousSubBlocks.forEach((previousSubBlock) {
      subBlockPosition.add(blockSquare(
          previousSubBlock.color, previousSubBlock.x, previousSubBlock.y));
    });

    return Stack(
      children: subBlockPosition,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screen_width.toDouble(),
        height: screen_height.toDouble(),
        decoration: BoxDecoration(
            color: Colors.indigoAccent.shade400,
            border: Border.all(width: GAME_AREA_BORDER, color: Colors.black54),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: drawBlock());
  }
}
