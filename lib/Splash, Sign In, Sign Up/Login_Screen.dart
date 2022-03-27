import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/constants.dart';
import '../Home Room/Home_Screen.dart';
import 'package:Home/Splash,%20Sign%20In,%20Sign%20Up/Sign_UpScreen.dart';
import 'Custom_Widgets.dart';

var userName;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _rememberMe = false;
  String login_State = "";
  final Email_Controller = TextEditingController();
  final Password_Controller = TextEditingController();

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;

                  if(_rememberMe) {
                    Remember_Me(
                        Email_Controller.text, Password_Controller.text);
                  }

                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          bool Valid = await Check_Valid_Auth(
              Email_Controller.text, Password_Controller.text);

          if (Valid) {
            // if(_rememberMe)
            //   Remember_Me(Email_Controller.text, Password_Controller.text);

            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage(userName);
            }));

            setState(() {
              login_State = "";
            });
          } else {
            setState(() {
              login_State = "Wrong Email or password";
            });
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
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

  @override
  Widget build(BuildContext context) {
    // return Check_Valid_Auth(Get_Saved_Email(), Get_Saved_Password()) ? InputPage() :
    return Scaffold(
       body: Container(
          height: double.infinity,
          color:  background_Color,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 120.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 30.0),
                BuildEmailTF(Email_Controller),
                SizedBox(
                  height: 30.0,
                ),
                BuildPasswordTF(Password_Controller),
                SizedBox(
                  height: 30.0,
                ),
                _buildRememberMeCheckbox(),
                _buildLoginBtn(),
                BuildGo_SignUp(context),
                Text(login_State)
              ],
            ),
          ),
        )
    );
  }
}

Check_Valid_Auth(String Email, String Password) async {
  if (Email != "" && Password != "") {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: Email, password: Password);
      print(userCredential.user);
      User? user = userCredential.user;
      userName = user?.displayName;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        return false;
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        return false;
      }
    }
  } else {
    return false;
  }
}

void Remember_Me(String Email, String Password)
{
   //Save data to local
}







