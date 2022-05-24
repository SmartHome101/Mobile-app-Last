import 'package:Home/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../shared/constants.dart';
import '../shared/Custom_Widgets.dart';
import '../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreen createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  String? code, fullName, email, password;

  // final Name_Controller = TextEditingController();
  // final Email_Controller = TextEditingController();
  // final Password_Controller = TextEditingController();
  // final Code_Controller = TextEditingController();

  // bool validateUserName(userName) {
  //   if (userName == "") {
  //     setState(() {
  //       signup_state = "UserName Cannot Be Empty!";
  //     });
  //     return false;
  //   } else if (userName.length < 8) {
  //     setState(() {
  //       signup_state = "userName Must Be At Least 8 Characters!";
  //     });
  //     return false;
  //   }
  //   bool userNameValid =
  //       RegExp(r"^(?=[a-zA-Z0-9._]{8,20}$)(?!.*[_.]{2})[^_.].*[^_.]$")
  //           .hasMatch(userName);
  //   if (!userNameValid) {
  //     setState(() {
  //       signup_state = "InValid UserName";
  //     });
  //     return false;
  //   }
  //   return true;
  // }
  // bool validateMail(email) {
  //   if (email == "") {
  //     setState(() {
  //       signup_state = "Email Cannot Be Empty!";
  //     });
  //     return false;
  //   }
  //   bool emailValid = RegExp(
  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
  //       .hasMatch(email);
  //   if (!emailValid) {
  //     setState(() {
  //       signup_state = "InValid Email";
  //     });
  //   }
  //   return emailValid;
  // }
  //
  // bool validatePassowrd(password) {
  //   if (password == "") {
  //     setState(() {
  //       signup_state = "Password Cannot Be Empty!";
  //     });
  //     return false;
  //   } else if (password.length < 8) {
  //     setState(() {
  //       signup_state = "Password Must Be At Least 8 Characters!";
  //     });
  //     return false;
  //   }
  //   return true;
  // }
  void reset() {
    setState(() {
      code = "";
      fullName = "";
      email = "";
      password = "";
    });
  }

  Sign_Up_Account() async {
    try {
      isLoading = true;
      setState(() {});

      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      User? user = userCredential.user;
      await user!.updateDisplayName(fullName);
      await user.updatePhotoURL("icons/vector.png");

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Weak Password")));
      } else if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email already exists")));
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

  // Widget _buildGo_SignUp() {
  //   return Container(
  //     alignment: Alignment.center,
  //     child: ElevatedButton(
  //       style: buttonStyle(Size(200, 50)),
  //       onPressed: () async {
  //         if (formKey.currentState!.validate()) {
  //           await Sign_Up_Account(Name_Controller.text, Email_Controller.text,
  //               Password_Controller.text);
  //         } else {}
  //       },
  //       child: Text(
  //         'Sign Up',
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

  Widget _buildLoginBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 0.0, top: 8.0, right: 0, bottom: 8.0),
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
    );
  }

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
                  // BuildCode(Code_Controller),
                  // SizedBox(height: 15.0),
                  // BuildUserName(Name_Controller),
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // BuildEmailTF(Email_Controller),
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // BuildPasswordTF(Password_Controller),
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // Text(signup_state),
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // _buildGo_SignUp(),
                  _buildLoginBtn(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
