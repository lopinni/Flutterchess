import 'package:flutter/material.dart';
import 'register_page.dart';

void main() {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutterchess',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: RegisterPage(),
    );
  }

}