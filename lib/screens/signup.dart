import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MySignUpPage extends StatefulWidget{
  @override
  _SignUpPageState createState() => new _SignUpPageState();

}

class _SignUpPageState extends State<MySignUpPage>{
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Container buildTitle(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      alignment: Alignment.bottomCenter,
      height: 60.0,
      child: Text('Welcome!', style: TextStyle(fontSize: 18.0, color: theme.primaryColorDark),),
    );
  }


  Padding buildText(String text, double fontSize, ThemeData theme) {
  return Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(text, style: TextStyle(color: theme.primaryColorDark, fontSize: fontSize,),),
  );
  }

  Padding buildInputField(String labelText, String hintText, bool isObscured, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: TextFormField(
              onSaved:(input){
            if(labelText == 'Email'){
           _email = input;
           }
            else if(labelText == 'password' ){
              _password = input;
            }
            },
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          hintStyle: TextStyle(color: theme.primaryColorDark),
        ),
        obscureText: isObscured,
      ),
    );
  }

  SizedBox buildSignUpBtn(ThemeData theme) {
    return SizedBox(
      width: 250.0,
      child: RaisedButton(
        onPressed: signUp,
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        color: theme.buttonColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: Text('Sign up with email'),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return new Scaffold(
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16.0, kToolbarHeight, 16.0, 16.0),
        children: <Widget>[
          Align(
            child: SizedBox(
              width: 320.0,
              child: Card(
                color: theme.primaryColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    buildTitle(theme),
                    buildText('Sign up with your email address', 12.0, theme),
                    buildInputField('Name', 'Your name',false,theme),
                    buildInputField('Email', 'Your@email.com', false, theme),
                    buildInputField('Password', '', true, theme),
                    SizedBox(height: 18.0,),
                    buildSignUpBtn(theme),
                    buildText('By signing up you agree with our Terms & Conditions.', 8.0, theme),
                    SizedBox(height: 18.0,),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<void> signUp() async {
    final formState= _formkey.currentState;
     if(formState.validate()){
       try{
         formState.save();
         AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email:_email ,password: _password);
         user.user.sendEmailVerification();
         Navigator.of(context).pop();
       }
       catch(e){
         print(e.message);
       }

     }
   }
}





//      Form(
//        key: _formkey,
//        child: Column(
//          children: <Widget>[
//            TextFormField(
//              validator:(input){
//                if(input.isEmpty){
//                  return "Please enter email";
//                }
//              } ,
//              onSaved:(input) => _email = input,
//              decoration: InputDecoration(
//                  labelText:'Email'
//              ),
//              obscureText: true,
//            ),
//              TextFormField(
//                validator:(input){
//                  if(input.length < 6){
//                    return "Valid password should be atleast 6 characters";
//                  }
//                } ,
//                onSaved:(input) => _password = input,
//                decoration: InputDecoration(
//                  labelText:'Password'
//                ),
//                obscureText: true,
//              ),
//            RaisedButton(
//              onPressed: signIn,
//              child: Text('Sign in'),
//            )
//          ],
//        ),
//      ),
