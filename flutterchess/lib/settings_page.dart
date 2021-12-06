import 'package:flutter/material.dart';
import 'package:flutterchess/chess_page.dart';
import 'package:flutter_stateless_chessboard/flutter_stateless_chessboard.dart' as cb;
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class SettingsPage extends StatefulWidget {

  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {

  String dropdownValue1 = "Komputerem";
  cb.Color dropdownValue2 = cb.Color.WHITE;
  String dropdownValue3 = "Brak";
  Color colorBlack = Color.fromRGBO(181, 136, 99, 1);
  Color colorWhite = Color.fromRGBO(240, 217, 181, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutterchess ustawienia gry"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Rozgrywka z:",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue1,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue1 = newValue!;
                      });
                    },
                    items: <String>['Komputerem', 'Człowiekiem']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ]
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Kolor gracza u dołu:",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton<cb.Color>(
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (cb.Color? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                    items: <cb.Color>[cb.Color.WHITE, cb.Color.BLACK]
                        .map<DropdownMenuItem<cb.Color>>((cb.Color value) {
                      return DropdownMenuItem<cb.Color>(
                        value: value,
                        child: Text((value == cb.Color.WHITE) ? "Biały" : "Czarny"),
                      );
                    }).toList(),
                  ),
                ]
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Czas na ruch:",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  DropdownButton<String>(
                    value: dropdownValue3,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue3 = newValue!;
                      });
                    },
                    items: <String>['Brak', '5min', '2min', '1min']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ]
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Kolor ciemnych pól:",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              MaterialColorPicker(
                  onColorChange: (Color color) {
                    colorBlack = color;
                  },
                  selectedColor: Colors.red
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Kolor jasnych pól:",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              MaterialColorPicker(
                  onColorChange: (Color color) {
                    colorWhite = color;
                  },
                  selectedColor: Colors.green
              ),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChessPage(
                        opponent: dropdownValue1,
                        orientation: dropdownValue2,
                        timeLimit: dropdownValue3,
                        colorBlack: colorBlack,
                        colorWhite: colorWhite,
                      )),
                    );
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Zagraj",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

}