import 'package:flutter/material.dart';
import 'screens/welcomepage.dart';
import 'popups/custom_dialogue.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'fundi',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color(0xFFE8716D),
        primaryColor: Color(0xFF2E3E52),
        buttonColor: Color(0xFF6ADCC8),
        primaryColorDark: Color(0xFF7C8BA6)

      ),
      home: WelcomePage(),
      routes: <String, WidgetBuilder>{
        "/signup": (BuildContext context) => CustomDialog(),
         "/home": (BuildContext context) => CustomDialog()
      },
    );
  }
}