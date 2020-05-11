import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  void play(int numNote) {
    final player = AudioCache();
    player.play('note$numNote.wav');
  }

  Expanded noteButton(String note, int numNote) {
    int colorInta = Random().nextInt(255);
    int colorIntb = Random().nextInt(255);
    int colorIntc = Random().nextInt(255);
    int colorIntd = Random().nextInt(255);

    return Expanded(
      child: FlatButton(
        color: Color.fromARGB(255, colorIntb, colorIntc, colorIntd),
        onPressed: () {
          play(numNote);
        },
        child: Text(note),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              noteButton('DO', 1),
              noteButton('RE', 2),
              noteButton('MI', 3),
              noteButton('FA', 4),
              noteButton('SO', 5),
              noteButton('LA', 6),
              noteButton('SI', 7),
            ],
          ),
        ),
      ),
    );
  }
}
