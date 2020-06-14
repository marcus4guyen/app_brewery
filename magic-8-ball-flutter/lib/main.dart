import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(
      MaterialApp(
        home: MagicBallPage(),
      ),
    );

class MagicBallPage extends StatefulWidget {
  @override
  _MagicBallPageState createState() => _MagicBallPageState();
}

class _MagicBallPageState extends State<MagicBallPage> {
  final _random = Random();
  int _next() => 1 + _random.nextInt(5);

  int _randomAnswer = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask Me Anything'),
        backgroundColor: Colors.blue.shade900,
      ),
      body: Container(
        color: Colors.blue,
        child: Center(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _randomAnswer = _next();
              });
            },
            child: Image.asset('images/ball$_randomAnswer.png'),
          ),
        ),
      ),
    );
  }
}
