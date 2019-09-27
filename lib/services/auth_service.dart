import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import '../screens/specialist_signin_view.dart';
import 'dart:io';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );


  //sign in with gmailbutton
  Future<String> signInWithGoogle() async {}

  //signOut
  void signOutGoogle() async {}

  //each user's Uid
  Future<String> getCurrentUID() async {
    String uid = (await _firebaseAuth.currentUser()).uid;
    return uid;
  }

  //signup with E-MAIL AND PASSWORD
  Future<String> createUserWithEmailAndPassword(String _email, String _password,
      String _name) async {
    final currentUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    );
    // update username
    await updateUserName(_name, currentUser.user);
    return currentUser.user.uid;
  }

  //signup as Specialist
  Future<String> createSpecialistWithEmailAndPassword(String _email, String _password, String _name, String _phoneNumber) async {
    final currentSpecialist = await _firebaseAuth
        .createUserWithEmailAndPassword(email: _email, password: _password);
    await updateUserName(_name, currentSpecialist.user);
    return currentSpecialist.user.uid;
  }


  Future updateUserName(String _name, FirebaseUser currentUser) async {
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = _name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
    return currentUser.uid;
  }

  //sign in with emaIL AND PASSWORD
  Future<String> signInWithEmailAndPassword(
      String _email, String _password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password))
        .user
        .uid;
  }

//Sign out
  signOut() {
    return _firebaseAuth.signOut();
  }
}
