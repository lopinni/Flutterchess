import 'package:flutter/material.dart';
import 'package:flutter_chess_board/flutter_chess_board.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NonLoginPage extends StatefulWidget {

  @override
  _NonLoginPageState createState() => _NonLoginPageState();

}

class _NonLoginPageState extends State<NonLoginPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutterchess free"),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 60.0,
          ),
          Center(
            child: ChessBoard(
              size: 400,
              boardType: BoardType.green,
              onMove: (move) {
                Fluttertoast.showToast(
                    msg: move,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.greenAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              onCheckMate: (color) {
                Fluttertoast.showToast(
                    msg: "Szach mat",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.greenAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              onCheck: (color) {
                Fluttertoast.showToast(
                    msg: "Szach",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.greenAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              onDraw: () {
                Fluttertoast.showToast(
                    msg: "Remis",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.greenAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {
              setState(() {});
            },
            child: Text(
              "Resetuj szachownicę",
              style: TextStyle(
                  color: Colors.blue, fontWeight: FontWeight.w900),
            ),
          )
        ]
      ),
    );
  }

}