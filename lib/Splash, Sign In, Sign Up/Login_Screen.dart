import 'dart:async';
import 'package:Home/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Home Room/Home_Screen.dart';
import '../shared/constants.dart';
import '../shared/Custom_Widgets.dart';
import '../Controllers/shared_preferences.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? email, password;

  String? userName, photoURL;

  bool isLoading = false;
  bool _rememberMe = false;

  // final Email_Controller = TextEditingController();
  // final Password_Controller = TextEditingController();

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
      email = "";
      password = "";
    });
  }

  // bool validateMail(email) {
  //   if (email == "") {
  //     setState(() {
  //       login_State = "Email Cannot Be Empty!";
  //     });
  //     return false;
  //   }
  //   bool emailValid = RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(email);
  //   if (!emailValid) {
  //     setState(() {
  //       login_State = "InValid Email";
  //     });
  //   }
  //   return emailValid;
  // }
  // bool validatePassowrd(password) {
  //   if (password == "") {
  //     setState(() {
  //       login_State = "Password Cannot Be Empty!";
  //     });
  //     return false;
  //   } else if (password.length < 8) {
  //     setState(() {
  //       login_State = "Password Must Be At Least 8 Characters!";
  //     });
  //     return false;
  //   }
  //   return true;
  // }

  Check_Valid_Auth() async {
    try {
      isLoading = true;
      setState(() {});

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      User? user = userCredential.user;
      userName = user?.displayName;
      photoURL = user?.photoURL;

      if (_rememberMe) {
        await CacheHelper.saveData(key: "userName", value: userName);
        await CacheHelper.saveData(key: "photoURL", value: photoURL);
      }
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(userName, photoURL);
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User Not Found")));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Invalid Mail or Password")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something Went Wrong please Try again")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Something Went Wrong")));
    }
    isLoading = false;
    setState(() {});
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

  // Widget _buildLoginBtn() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 25.0),
  //     alignment: Alignment.center,
  //     child: ElevatedButton(
  //       style: buttonStyle(Size(200, 50)),
  //       onPressed: () async {
  //         bool Valid = await Check_Valid_Auth(
  //             Email_Controller.text, Password_Controller.text);
  //         if (Valid) {
  //           login_State = "";
  //           Navigator.pop(context);
  //           Navigator.push(context, MaterialPageRoute(builder: (context) {
  //             return HomePage(userName, photoURL);
  //           }));
  //         }
  //       },
  //       child: Text(
  //         'LOGIN',
  //         style: TextStyle(
  //           color: Colors.white,
  //           letterSpacing: 1.5,
  //           fontSize: 18.0,
  //           fontWeight: FontWeight.bold,
  //           fontFamily: 'OpenSans',
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: Color(0xff2B475E),
          resizeToAvoidBottomInset: true,
          body: Container(
            height: double.infinity,
            // decoration: Background_decoration(),
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
                  child: Form(
                    key: formKey,
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
                        CustomTextField(
                          hintText: 'Email',
                          onChanged: (data) {
                            email = data;
                          },
                          isPassword: false,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        CustomTextField(
                          hintText: 'Password',
                          onChanged: (data) {
                            password = data;
                          },
                          isPassword: true,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        _buildRememberMeCheckbox(),
                        SizedBox(
                          height: 30.0,
                        ),
                        CustomeButton(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await Check_Valid_Auth();
                              } else {}
                            },
                            title: "Log In"),
                        // _buildLoginBtn()
                        // ,
                        SizedBox(
                          height: 10.0,
                        ),
                        BuildGo_SignUp(context, reset),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
