import 'package:flutter/material.dart';
import 'package:tetris/block/block.dart';
import 'package:tetris/block/sub_block.dart';

class OBlock extends Block {
  OBlock(int rotationIndex)
      : super([
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
    [SubBlock(0, 0), SubBlock(1, 0), SubBlock(0, 1), SubBlock(1, 1)],
  ], Colors.deepOrange[300], rotationIndex);
}