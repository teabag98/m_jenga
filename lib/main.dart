import 'package:flutter/material.dart';
import 'package:m_fundi/screens/specialist_signin_view.dart' as prefix1;
import 'package:m_fundi/services/auth_service.dart';
import 'screens/welcomepage.dart';
import 'screens/specialist_signin_view.dart';
import 'popups/custom_dialogue.dart';
import 'screens/provider.dart';
import 'screens/customer_signin_view.dart' as prefix0;
import 'screens/customer_signin_view.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        title: 'fundi',
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Color(0xFFE8716D),
          primaryColor: Color(0xFF2E3E52),
          buttonColor: Color(0xFF6ADCC8),
          primaryColorDark: Color(0xFF7C8BA6)

        ),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          "/signup": (BuildContext context) => SignUpView(authFormType: prefix0.AuthFormType.signUp),
          "/signIn": (BuildContext context) => SignUpView(authFormType: prefix0.AuthFormType.signIn),
           "/home": (BuildContext context) => HomeController(),
          "/signUpSpecialist": (BuildContext context) => SignUpSpecialistView(authFormTypeSpecialist: prefix1.AuthFormType.signUp,)
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
      stream: auth.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot ){
        if(snapshot.connectionState == ConnectionState.active){
          final bool signIn = snapshot.hasData;
          return signIn ? SignUpView(): WelcomePage();
        }
        return CircularProgressIndicator(strokeWidth: 5.0,);
      },
    );
  }
}

