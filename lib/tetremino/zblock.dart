import 'package:flutter/material.dart';
import 'package:tetris/block/block.dart';
import 'package:tetris/block/sub_block.dart';

class ZBlock extends Block {
  ZBlock(int rotationIndex)
      : super([
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
    [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(1, 1), SubBlock(2, 1)],
    [SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1), SubBlock(0, 2)],
  ], Colors.cyan[200], rotationIndex);
}
