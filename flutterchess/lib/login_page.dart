import 'package:flutter/material.dart';
import 'package:flutterchess/settings_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyLoginPage extends StatefulWidget {

  @override
  _MyLoginPageState createState() => _MyLoginPageState();

}

class _MyLoginPageState extends State<MyLoginPage> {

  final _auth = FirebaseAuth.instance;
  bool showProgress = false;
  late String email, password;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutterchess logowanie"),
      ),
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: showProgress,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Logowanie",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value; // get value from TextField
                },
                decoration: InputDecoration(
                    hintText: "Adres e-mail",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
              SizedBox(
                height: 20.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value; //get value from textField
                },
                decoration: InputDecoration(
                    hintText: "Hasło",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32.0)))),
              ),
              SizedBox(
                height: 20.0,
              ),
              Material(
                elevation: 5,
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(32.0),
                child: MaterialButton(
                  onPressed: () async {
                    setState(() {
                      showProgress = true;
                    });
                    try {
                      final newUser = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      print(newUser);
                      setState(() {
                        showProgress = false;
                      });
                    } catch (e) {}
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                  minWidth: 200.0,
                  height: 45.0,
                  child: Text(
                    "Zaloguj się",
                    style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}