import 'dart:async';
import 'package:Home/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Controllers/authentication_servies.dart';
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

  @override
  Widget build(BuildContext context) {
    signInToFirebase() async {
      isLoading = true;
      setState(() {});

      var result = await context
          .read<AuthenticationService>()
          .signIn(email: email!, password: password!);
      if (result != "success" && result != "error") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
      } else if (result == "error") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something Went Wrong please Try again")));
      }

      isLoading = false;
      setState(() {});
    }

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
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
                          icon: Icons.email,
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
                          icon: Icons.lock,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        // _buildRememberMeCheckbox(),
                        // SizedBox(
                        //   height: 30.0,
                        // ),
                        CustomeButton(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                await signInToFirebase();
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
