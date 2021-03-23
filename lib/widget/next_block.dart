import 'package:flutter/material.dart';

class NextBlock extends StatefulWidget {
  @override
  _NextBlockState createState() => _NextBlockState();
}

class _NextBlockState extends State<NextBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.white54),
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Next Block',
            style: TextStyle(color: Colors.indigo,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Colors.indigo.shade500,
            ),
          )
        ],
      ),
    );
  }
}
