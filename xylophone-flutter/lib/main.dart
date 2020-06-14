import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  final _player = AudioCache();
  final List<dynamic> _configurableUI = [
    {'color': Colors.red, 'sound': 'note1.wav'},
    {'color': Colors.orange, 'sound': 'note2.wav'},
    {'color': Colors.yellow, 'sound': 'note3.wav'},
    {'color': Colors.green, 'sound': 'note4.wav'},
    {'color': Colors.teal, 'sound': 'note5.wav'},
    {'color': Colors.blue, 'sound': 'note6.wav'},
    {'color': Colors.purple, 'sound': 'note7.wav'},
  ];

  List<Widget> _listButtons() {
    List<Widget> children = [];

    for (int i = 0; i < _configurableUI.length; i++) {
      children.add(
        Expanded(
          child: FlatButton(
            color: _configurableUI[i]['color'],
            onPressed: () {
              _player.play(_configurableUI[i]['sound']);
            },
          ),
        ),
      );
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _listButtons(),
          ),
        ),
      ),
    );
  }
}
