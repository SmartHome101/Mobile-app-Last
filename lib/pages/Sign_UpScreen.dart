import 'package:Home/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import '../shared/constants.dart';
import '../shared/Custom_Widgets.dart';
import '../widgets/custom_text_field.dart';
import '../Controllers/authentication_servies.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? code, fullName, email, password;

  void reset() {
    setState(() {
      code = "";
      fullName = "";
      email = "";
      password = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    Sign_Up_Account() async {
      isLoading = true;
      setState(() {});

      var result = await context.read<AuthenticationService>().signUp(
          email: email!,
          password: password!,
          fullName: fullName,
          code: code,
          photoURL: "icons/vector.png");

      if (result == "success") {
        Navigator.pop(context);
      } else if (result == "error") {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Something Went Wrong please Try again")));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(result)));
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
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: 20.0,
            ),
            child: Form(
              key: formKey,
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
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomTextField(
                    hintText: 'House Code',
                    onChanged: (data) {
                      code = data;
                    },
                    isPassword: false,
                    icon: Icons.code,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomTextField(
                    hintText: 'Full Name',
                    onChanged: (data) {
                      fullName = data;
                    },
                    isPassword: false,
                    icon: Icons.man,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  CustomTextField(
                    hintText: 'Email address',
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
                  CustomeButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          await Sign_Up_Account();
                        } else {}
                      },
                      title: "Sign Up"),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 8.0, right: 0, bottom: 8.0),
                      child: TextButton(
                        onPressed: () {
                          reset();
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
                          style: kLabelStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
