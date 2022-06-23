import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/authentication_servies.dart';
import '../Controllers/shared_preferences.dart';
import '../Splash, Sign In, Sign Up/Login_Screen.dart';
import '../Splash, Sign In, Sign Up/Sign_UpScreen.dart';
import 'constants.dart';

//Custom Email,Password and Username widgets

Widget BuildEmailTF(TextEditingController Email_Controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Email',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.email,
              color: Colors.white,
            ),
            hintText: 'Enter your Email',
            hintStyle: kHintTextStyle,
          ),
          controller: Email_Controller,
        ),
      ),
    ],
  );
}

Widget BuildPasswordTF(TextEditingController Password_Controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Password',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          obscureText: true,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.white,
            ),
            hintText: 'Enter your Password',
            hintStyle: kHintTextStyle,
          ),
          controller: Password_Controller,
        ),
      ),
    ],
  );
}

Widget BuildUserName(TextEditingController Name_Controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'Name',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.light,
              color: Colors.white,
            ),
            hintText: 'Enter your name',
            hintStyle: kHintTextStyle,
          ),
          controller: Name_Controller,
        ),
      ),
    ],
  );
}

Widget BuildCode(TextEditingController Code_Controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        'House Code',
        style: kLabelStyle,
      ),
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        child: TextFormField(
          validator: (data) {
            if (data!.isEmpty) {
              return "Field is Required";
            }
          },
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.light,
              color: Colors.white,
            ),
            hintText: 'Enter the code',
            hintStyle: kHintTextStyle,
          ),
          controller: Code_Controller,
        ),
      ),
    ],
  );
}

Widget BuildGo_SignUp(BuildContext context, void Function() reset) {
  return Container(
    alignment: Alignment.centerRight,
    child: Padding(
      padding:
          const EdgeInsets.only(left: 0.0, top: 8.0, right: 0, bottom: 8.0),
      child: TextButton(
        onPressed: () {
          reset();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SignUpScreen();
          }));
        },
        child: Text(
          "Don't have an account? Sign Up",
          style: kLabelStyle,
        ),
      ),
    ),
  );
}

BoxDecoration Background_decoration() {
  return BoxDecoration(
      image: DecorationImage(
          image: AssetImage('icons/Background.jpg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black12,
            BlendMode.darken,
          )));
}

Widget BuildUserName_Customized(
    TextEditingController Name_Controller, String displayName) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(height: 10.0),
      Container(
        alignment: Alignment.centerLeft,
        decoration: kBoxDecorationStyle,
        height: 60.0,
        width: 200,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'OpenSans',
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14.0),
            prefixIcon: Icon(
              Icons.light,
              color: Colors.white,
            ),
            hintText: displayName,
            hintStyle: kHintTextStyle,
          ),
          controller: Name_Controller,
        ),
      ),
    ],
  );
}

Widget Build_Logout(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      child: Text(
        'Log out',
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.5,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans',
        ),
      ),
      style: buttonStyle(Size(250, 50)),
      onPressed: () async {
        await context.read<AuthenticationService>().signOut();
        // await CacheHelper.RemoveData(key: 'userName');
        // Navigator.pop(context);
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return LoginScreen();
        // }));
      },
    ),
  );
}

ButtonStyle buttonStyle(Size _size) {
  return ElevatedButton.styleFrom(
    minimumSize: _size,
    primary: Colors.blueAccent,
    onPrimary: Colors.white10,
    shape: new RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(40.0),
      side: BorderSide(color: Colors.blue),
    ),
  );
}
