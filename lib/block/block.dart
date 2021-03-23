import 'package:flutter/material.dart';
import 'package:tetris/block/sub_block.dart';

enum BlockMovement { RIGHT, LEFT, DOWN, ROTATE }

class Block {
  List<List<SubBlock>> orientations = List<List<SubBlock>>();
  //List<SubBlock> block = [SubBlock(1, 2), SubBlock(2, 3), SubBlock(4, 5), SubBlock(5, 8)];

  int x;
  int y;
  int rotationIndex; // 0 - 3

  Block(this.orientations, Color color, this.rotationIndex) {
    x = 3;
    y = 0;
    this.color = color;
  }

  set color(Color color) {
    orientations.forEach((subColor) {
      subColor.forEach((subBlockColor) {
        subBlockColor.color = color;
      });
    });
  }

  // first subBlock color
  get subBlockColor {
    return orientations[0][0].color; // 0 - 3 subBlock color
  }

// sub-block orientations index
  get subBlocks {
    return orientations[rotationIndex];
  }

  // total lower block width, maX = 4
  get width {
    int maX = 0;
    subBlocks.forEach((subBlock) {
      if (subBlock.x > maX) maX = subBlock.x;
    });
    return maX + 1;
  }

  // total lower block height, maxY = 4
  get height {
    int maxY = 0;
    subBlocks.forEach((subBlock) {
      if (subBlock.y > maxY) maxY = subBlock.y;
    });
    return maxY + 1;
  }

  void move(BlockMovement blockMove) {
    switch (blockMove) {
      case BlockMovement.DOWN:
        y += 1;
        break;
      case BlockMovement.RIGHT:
        x += 1;
        break;
      case BlockMovement.LEFT:
        x -= 1;
        break;
      case BlockMovement.ROTATE:
        rotationIndex++;
        if (rotationIndex % 4 == 0) {
          rotationIndex = 0;
        }
        break;
    }
  }
}
