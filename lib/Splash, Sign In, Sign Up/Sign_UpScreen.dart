import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/constants.dart';
import '../shared/Custom_Widgets.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  String signup_state = "";
  final Name_Controller = TextEditingController();
  final Email_Controller = TextEditingController();
  final Password_Controller = TextEditingController();
  bool validateUserName(userName) {
    if (userName == "") {
      setState(() {
        signup_state = "UserName Cannot Be Empty!";
      });
      return false;
    } else if (userName.length < 8) {
      setState(() {
        signup_state = "userName Must Be At Least 8 Characters!";
      });
      return false;
    }
    bool userNameValid =
        RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$")
            .hasMatch(userName);
    if (!userNameValid) {
      setState(() {
        signup_state = "InValid UserName";
      });
      return false;
    }
    return true;
  }

  bool validateMail(email) {
    if (email == "") {
      setState(() {
        signup_state = "Email Cannot Be Empty!";
      });
      return false;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      setState(() {
        signup_state = "InValid Email";
      });
    }
    return emailValid;
  }

  bool validatePassowrd(password) {
    if (password == "") {
      setState(() {
        signup_state = "Password Cannot Be Empty!";
      });
      return false;
    } else if (password.length < 8) {
      setState(() {
        signup_state = "Password Must Be At Least 8 Characters!";
      });
      return false;
    }
    return true;
  }

  Sign_Up_Account(String Name, String Email, String Password) async {
    if (validateUserName(Name) &&
        validateMail(Email) &&
        validatePassowrd(Password)) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: Email, password: Password);
        User? user = userCredential.user;
        user?.updateProfile(displayName: Name);
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            signup_state = "The password provided is too weak.";
          });
          return false;
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            signup_state = 'The account already exists for that email.';
          });
          return false;
        }
      } catch (e) {
        setState(() {
          signup_state = 'Something Went Wrong, Please try again';
        });
      }
    } else {
      return false;
    }
  }

  Widget _buildGo_SignUp() {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () async {
          bool Value = await Sign_Up_Account(Name_Controller.text,
              Email_Controller.text, Password_Controller.text);
          if (Value) {
            setState(() {
              signup_state = "";
            });
            Navigator.pop(context);
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
        color: appMainColor,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 40.0,
            vertical: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(width: 35),
                  Image.asset(
                    "icons/Home_Icon.png",
                    scale: 5,
                  ),
                  SizedBox(width: 15.0),
                  Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
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
              Text(signup_state)
            ],
          ),
        ),
      ),
    );
  }
}
