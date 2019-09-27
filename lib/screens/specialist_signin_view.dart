import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'provider.dart';
import 'package:firebase_storage/firebase_storage.dart';


final primaryColor = const Color(0xFF75A2EA);
enum AuthFormType { signIn, signUp }

class SignUpSpecialistView extends StatefulWidget {
  final AuthFormType authFormTypeSpecialist;

  SignUpSpecialistView({Key key, @required this.authFormTypeSpecialist})
      : super(key: key);

  @override
  _SignUpSpecialistViewState createState() => _SignUpSpecialistViewState(
      authFormTypeSpecialist: this.authFormTypeSpecialist);
}

class _SignUpSpecialistViewState extends State<SignUpSpecialistView> {
  AuthFormType authFormTypeSpecialist;

  _SignUpSpecialistViewState({this.authFormTypeSpecialist});

  final _specialistFormKey = GlobalKey<FormState>();

  String _email, _password, _name, _phoneNumber;
  File _image;
  bool _autoValidate = false;

  // get image from gallery
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  //upload cv image to firestore
  Future uploadPicture(BuildContext context) async {
    String fileName = path.basename(_image.path);
    StorageReference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    setState(() {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('C.v uploaded successfully')));
    });
  }

  void submit() async {
    final form = _specialistFormKey.currentState;
    form.save();
    final auth = Provider.of(context).auth;

    String uid = await auth.createSpecialistWithEmailAndPassword(
        _email, _password, _name, _phoneNumber);

    //ToDo: navigator to google maps
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
                  key: _specialistFormKey,
                  child: Column(
                    children: buildInputs(),
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
    String _headerText = 'Create New Account';

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
    textField.add(
      TextFormField(
        style: TextStyle(fontSize: 19),
        decoration: buildSignUpInputDecoration("Name"),
        onSaved: (value) => _name = value,
      ),
    );
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
    textField.add(
      TextFormField(
        style: TextStyle(fontSize: 19),
        decoration: buildSignUpInputDecoration("Phone number"),
        onSaved: (value) => _phoneNumber = value,
      ),
    );

    textField.add(SizedBox(height: 15.0));
    textField.add(Text('Upload any certification'));
    textField.add(SizedBox(height: 5.0));
    textField.add(
      ClipRect(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.5,
            //ToDO change white to primaryColor
            color: Colors.white,
            child: (_image != null)
                ? Image.file(_image, fit: BoxFit.fill)
                : Image.network(
                    'https://www.caribbeanmarineatlas.net/static/documents/docx-placeholder.png')),
      ),
    );
    textField.add(SizedBox(height: 5.0));

    textField.add(RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.cyan,
      icon: Icon(Icons.attach_file),
      label: Text('Upload C.v'),
      onPressed: getImage,
    ));

    textField.add(SizedBox(height: 25.0));

    textField.add(RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.cyan,
      textColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text('Apply For Validation'),
      ),
      onPressed: () {
        uploadPicture(context);
      },
    ));
    //ToDo : add specialist signup UI

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
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0));
  }
}
