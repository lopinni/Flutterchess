import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart' as cb;
import 'package:chess/chess.dart' as ch;
import 'package:fluttertoast/fluttertoast.dart';

class ChessPage extends StatefulWidget {

  final String? opponent;
  final cb.Color? orientation;
  final String? timeLimit;
  final Color? colorBlack;
  final Color? colorWhite;

  const ChessPage({ Key? key,
                    this.opponent,
                    this.orientation,
                    this.timeLimit,
                    this.colorBlack,
                    this.colorWhite
                  }) : super(key: key);

  @override
  _ChessPageState createState() => _ChessPageState();

}

class _ChessPageState extends State<ChessPage> {

  String _fen = 'rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1';
  bool first = true;
  late CountdownTimerController controller;

  void onEnd() {
    Fluttertoast.showToast(
        msg: "Koniec czasu",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.greenAccent,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutterchess"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (widget.timeLimit != 'Brak') ? CountdownTimer(
            textStyle: TextStyle(
              fontSize: 30,
              color: Colors.red,
            ),
            onEnd: onEnd,
            endTime: DateTime.now().millisecondsSinceEpoch +
                Duration(minutes:
                          (widget.timeLimit == '1min') ? 1 :
                          (widget.timeLimit == '2min') ? 2 : 5
                        ).inMilliseconds,
          ) : SizedBox(
            height: 0.0,
          ),
          cb.Chessboard(
            fen: (widget.orientation == cb.Color.WHITE)
                    ? _fen : getFenBlack(),
            size: size.width,
            orientation: widget.orientation,
            lightSquareColor: widget.colorWhite,
            darkSquareColor: widget.colorBlack,
            onMove: (move) {

              final nextFen = makeMove(_fen, {
                'from': move.from,
                'to': move.to,
                'promotion': 'q',
              });

              if (nextFen != null) {
                setState(() {
                  _fen = nextFen;
                });
                if(widget.opponent == "Komputerem") {
                  Future.delayed(Duration(milliseconds: 200)).then((_) {
                    final nextMove = getRandomMove(_fen);
                    if (nextMove != null) {
                      setState(() {
                        _fen = makeMove(_fen, nextMove)!;
                      });
                    } else {
                      Fluttertoast.showToast(
                          msg: "Wygrana",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.greenAccent,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  });
                }
              } else {
                Fluttertoast.showToast(
                    msg: "Wykonano nielegalny ruch",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.redAccent,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              },
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            "FEN: " + _fen,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
          ),
        ],
      ),
    );

  }

  String? makeMove(String fen, dynamic move) {

    final chess = ch.Chess.fromFEN(fen);
    if (chess.move(move))  return chess.fen;
    return null;

  }

  String? getRandomMove(String fen) {

    final chess = ch.Chess.fromFEN(fen);
    final moves = chess.moves();
    if (moves.isEmpty) return null;
    moves.shuffle();
    return moves.first;

  }

  String? getFenBlack() {

    if(first && widget.opponent == "Komputerem"){
      final chess = ch.Chess.fromFEN(_fen);
      final moves = chess.moves();
      moves.shuffle();
      if(chess.move(moves.first)) {
        _fen = chess.fen;
        first = false;
        return chess.fen;
      }
    } else return _fen;

  }

  @override
  void dispose() {

    controller.dispose();
    super.dispose();

  }

}