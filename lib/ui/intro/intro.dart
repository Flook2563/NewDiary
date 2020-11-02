import 'package:dear_diary/ui/auth/sign_up.dart';
import 'package:flutter/material.dart';

import '../auth/login.dart';
import 'intro_slide.dart';

class Intro extends StatelessWidget {
  static const routeName = 'intro';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                SizedBox( width: 8.0, height: 100.0, ),
                Text( 'Diary มหาสนุก', style: TextStyle(fontSize: 28.0, color: Colors.blue[700]), ),
                SizedBox( width: 8.0, height: 20.0, ),
                Container( width: 350.0, height: 350.0, 
                  child: Image.asset('images/game.png')
                ),
                Container(
                  width: 300,
                  height: 47,
                  margin: EdgeInsets.only(top: 20.0),
                  child: FlatButton(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFC4C4C4), width: 1.2),
                        borderRadius: BorderRadius.circular(30.0)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(Login.routeName);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}