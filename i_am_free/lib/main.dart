import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('I Am Free'),
      ),
      body: Image(
        image: AssetImage('images/freedom.jpg'),
        fit: BoxFit.cover,
      ),
    ),
  ));
}
