import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Custom_Widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool _rememberMe = false;
  String login_State = "";
  final Name_Controller = TextEditingController();
  final Email_Controller = TextEditingController();
  final Password_Controller = TextEditingController();

  Widget _buildGo_SignUp() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          bool Value = await Sign_Up_Account(Name_Controller.text,
              Email_Controller.text, Password_Controller.text);
          if (Value) {
            Navigator.pop(context);

            setState(() {
              login_State = "";
            });
          } else {
            setState(() {
              login_State = "Wrong Parameters";
            });
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Sign Up',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  Widget _buildLoginBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          "Sign In",
          style: kLabelStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      BuildUserName(Name_Controller),
                      SizedBox(
                        height: 30.0,
                      ),
                      BuildEmailTF(Email_Controller),
                      SizedBox(
                        height: 30.0,
                      ),
                      BuildPasswordTF(Password_Controller),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildGo_SignUp(),
                      _buildLoginBtn(),
                      Text(login_State)
                    ],
                  ),
                ),
              ),
    );
  }
}

Sign_Up_Account(String Name, String Email, String Password) async {
  if (Email != "" && Password != "") {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: Email, password: Password);
      User? user = userCredential.user;
      user?.updateProfile(displayName: Name);
      print(user);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return false;
      }
    } catch (e) {
      print(e);
    }
  } else {
    return false;
  }
}


