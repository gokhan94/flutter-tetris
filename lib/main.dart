import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris/score_counter.dart';
import 'package:tetris/tetris.dart';
import 'package:tetris/widget/next_block.dart';
import 'package:tetris/widget/score.dart';

void main() => runApp(ChangeNotifierProvider<Counter>(
      create: (context) => Counter(0),
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Tetris(),
    );
  }
}

class Tetris extends StatefulWidget {
  @override
  _TetrisState createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  GlobalKey<TetrisGameState> _keyGame = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tetris Game"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent.shade50,
      ),
      backgroundColor: Colors.indigoAccent,
      body: Column(
        children: [
          //Score(),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                    flex: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: TetrisGame(
                        key: _keyGame,
                      ),
                    )),
                Flexible(
                    flex: 1,
                    child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          children: [
                            NextBlock(),
                            SizedBox(
                              height: 50,
                            ),
                            FlatButton(
                              onPressed: () {
                                setState(() {
                                  _keyGame.currentState.gameStart();
                                });
                              },
                              child: Text(
                                "Start",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              color: Colors.indigo.shade800,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Score(),
                          ],
                        )))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _keyGame.currentState.moveLeft();
                      });
                    },
                    child: Icon(
                      Icons.arrow_left,
                      size: 40,
                      color: Colors.white,
                    ),
                    color: Colors.indigo.shade800,
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _keyGame.currentState.moveRotate();
                      });
                    },
                    child: Icon(
                      Icons.rotate_left_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                    color: Colors.indigo.shade800,
                  ),
                ),
                SizedBox(
                  width: 1,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _keyGame.currentState.moveRight();
                      });
                    },
                    child: Icon(
                      Icons.arrow_right,
                      size: 40,
                      color: Colors.white,
                    ),
                    color: Colors.indigo.shade800,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
