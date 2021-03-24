import 'package:flutter/material.dart';

class Counter with ChangeNotifier{
  int _score;

  Counter(this._score);

  int get score => _score;

  void setScore(int value){
    this._score = value;
    notifyListeners();
  }

  void scoreIncrement(int score){
    this._score = score++;
    notifyListeners();
  }
}