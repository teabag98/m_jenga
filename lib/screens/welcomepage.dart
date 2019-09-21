import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:m_fundi/popups/custom_dialogue.dart';

class WelcomePage extends StatelessWidget {
  final primaryColor = const Color(0xFF75A2EA);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.1),
                Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 44,
                  ),
                ),
                SizedBox(height: _height * 0.1),
                AutoSizeText(
                  'Bringing building services to you',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40),
                ),
                SizedBox(height: _height * 0.1),
                RaisedButton(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15.0, bottom: 15.0, left: 30.0, right: 30.0),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 28.0,
                          fontWeight: FontWeight.w300),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => CustomDialog(
                                  title:
                                      "Would you like to create a free account ?",
                                  description:
                                      "With an account, you'll be able to enjoy all available services",
                                  primaryButtonText: "Create an Account",
                                  primaryButtonRoute: "/signup",
                                  secondaryButtonText: "Maybe later",
                                  secondaryButtonRoute: "/home",
                                )
                        )
                    );
                  },
                ),
                SizedBox(height: _height * 0.1),
                FlatButton(
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 25,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
