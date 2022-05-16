import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Home Room/Home_Screen.dart';
import '../shared/constants.dart';
import '../shared/Custom_Widgets.dart';
import '../Controllers/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var userName;
  var photoURL;
  bool _rememberMe = false;
  String login_State = "";
  final Email_Controller = TextEditingController();
  final Password_Controller = TextEditingController();

  Offset _offset = Offset(0, -0.05);
  double _opacity = 0;
  Duration _duration = Duration(seconds: 1);

  Timer? timer;

  void initState() {
    timer = Timer(
        Duration(seconds: 0),
        () => setState(() {
              setState(() => _offset = const Offset(0, 0.05));
              setState(() => _opacity = 1);
            }));
  }

  void reset() {
    setState(() {
      login_State = '';
      Email_Controller.text = "";
      Password_Controller.text = "";
    });
  }

  bool validateMail(email) {
    if (email == "") {
      setState(() {
        login_State = "Email Cannot Be Empty!";
      });
      return false;
    }
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    if (!emailValid) {
      setState(() {
        login_State = "InValid Email";
      });
    }
    return emailValid;
  }

  bool validatePassowrd(password) {
    if (password == "") {
      setState(() {
        login_State = "Password Cannot Be Empty!";
      });
      return false;
    } else if (password.length < 8) {
      setState(() {
        login_State = "Password Must Be At Least 8 Characters!";
      });
      return false;
    }
    return true;
  }

  Check_Valid_Auth(String Email, String Password) async {
    if (validateMail(Email) && validatePassowrd(Password)) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: Email, password: Password);
        User? user = userCredential.user;
        print(user);
        userName = user?.displayName;
        photoURL = user?.photoURL;
        if (_rememberMe && userName != null) {
          await CacheHelper.saveData(key: "userName", value: userName);
          await CacheHelper.saveData(key: "photoURL", value: photoURL);
        }
        return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            login_State = 'No user found for that email.';
            Email_Controller.text = "";
            Password_Controller.text = "";
          });
          return false;
        } else if (e.code == 'wrong-password') {
          setState(() {
            login_State = 'Wrong mail or password.';
          });
          return false;
        } else {
          setState(() {
            login_State = e.code;
          });
        }
      } catch (e) {
        setState(() {
          login_State = 'Something Went Wrong, Please try again';
        });
      }
    } else {
      setState(() {
        login_State = 'Your Mail Or Password is invalid';
      });
    }
    return false;
  }

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
      alignment: Alignment.center,
      child: ElevatedButton(
        style: buttonStyle(Size(200, 50)),
        onPressed: () async {
          bool Valid = await Check_Valid_Auth(
              Email_Controller.text, Password_Controller.text);
          if (Valid) {
            login_State = "";
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomePage(userName, photoURL);
            }));
          }
        },
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
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
    return Scaffold(
        body: Container(
      height: double.infinity,
      decoration: Background_decoration(),
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 60.0,
        ),
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: _duration,
          child: AnimatedSlide(
            offset: _offset,
            duration: _duration,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      'Sign In',
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
                BuildGo_SignUp(context, reset),
                Text(login_State)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
