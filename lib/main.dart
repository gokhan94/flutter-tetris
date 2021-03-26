import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tetris/score_counter.dart';
import 'package:tetris/tetris.dart';
import 'package:tetris/widget/score_display.dart';

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
        title: Text("Flutter Tetris Game", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: Colors.yellow.shade700,
      ),
      backgroundColor: Colors.yellow.shade200,
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
                            ScoreDisplay(),
                            SizedBox(
                              height: 50,
                            ),
                            FlatButton(
                              shape: CircleBorder(),
                              height: 70,
                             /* shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),*/
                              onPressed: () {
                                setState(() {
                                  _keyGame.currentState.gameStart();
                                });
                              },
                              child: Text(
                                "Start",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                              color: Colors.green.shade800,
                            ),

                            SizedBox(
                              height: 50,
                            ),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                    color: Colors.yellow.shade900,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: () {
                      setState(() {
                        _keyGame.currentState.moveRotate();
                      });
                    },
                    child: Icon(
                      Icons.rotate_right,
                      size: 40,
                      color: Colors.white,
                    ),
                    color: Colors.orange.shade900,
                  ),
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                    color: Colors.yellow.shade900,
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
