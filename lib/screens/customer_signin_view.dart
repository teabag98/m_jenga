import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/auth_service.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'provider.dart';

final primaryColor = const Color(0xFF75A2EA);
enum AuthFormType { signIn, signUp }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;

  bool _showSpecialistSignupButton;

  _SignUpViewState({this.authFormType});

  final _formkey = GlobalKey<FormState>();
  String _email, _password, _name;
  bool _autoValidate = false;

  // change from signup view to signin & vice versa
  void switchFormState(String state) {
    _formkey.currentState.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else {
      authFormType = AuthFormType.signIn;
    }
  }

  void submit() async {
    final form = _formkey.currentState;
    form.save();
    try {
      final auth = Provider.of(context).auth;
      if (authFormType == AuthFormType.signIn) {
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print(uid);
        //ToDo: navigator to goodle maps

      } else {
        String uid =
            await auth.createUserWithEmailAndPassword(_email, _password, _name);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: primaryColor,
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(height: _height * 0.05),
              buildHeaderText(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signUp) {
      _headerText = 'Create New Account';
    } else {
      _headerText = 'Sign In';
    }

    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 35, color: Colors.white),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textField = [];
    textField.add(SizedBox(
      height: 19,
    ));
    if (authFormType == AuthFormType.signUp) {
      textField.add(
        TextFormField(
          style: TextStyle(fontSize: 19),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value,
        ),
      );
    }
    textField.add(SizedBox(
      height: 19,
    ));

    textField.add(
      TextFormField(
        style: TextStyle(fontSize: 19),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) => _email = value,
      ),
    );
    textField.add(SizedBox(
      height: 19,
    ));
    textField.add(
      TextFormField(
        style: TextStyle(fontSize: 19),
        decoration: buildSignUpInputDecoration("Password"),
        onSaved: (value) => _password = value,
      ),
    );

    textField.add(SizedBox(height: 15.0));

    return textField;
  }

  InputDecoration buildSignUpInputDecoration(String _hint) {
    return InputDecoration(
        hintText: _hint,
        filled: true,
        fillColor: Colors.cyan,
        focusColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.white,
            width: 0.0,
          ),
        ),

//        enabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(
//          color: Colors.white,
//          width: 0.0,
//        )),
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0));
  }

  List<Widget> buildButtons() {
    String _switchButton, _newFormState, _authButtonText;
    bool _becomeASpecialistButton;
    if (authFormType == AuthFormType.signIn) {
      _switchButton = "Create New Account";
      _authButtonText = "Sign In";
      _newFormState = "signUp";
      _becomeASpecialistButton = false;
    } else {
      _switchButton = "Have an account? Sign In";
      _authButtonText = "Sign Up";
      _newFormState = "signIn";
      _becomeASpecialistButton = true;
    }
    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.cyan,
          textColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(_authButtonText),
          ),
          onPressed: submit,
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
      FlatButton(
        child: Text(
          _switchButton,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
      Visibility(
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.cyan,
          textColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text('Become a Specialist'),
          ),
          onPressed: () {Navigator.of(context).pushReplacementNamed('/signUpSpecialist');},
        ),
        visible: _becomeASpecialistButton,
      )
    ];
  }
}
