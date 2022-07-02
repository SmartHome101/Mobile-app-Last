import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Controllers/authentication_servies.dart';
import '../Controllers/shared_preferences.dart';
import '../Splash, Sign In, Sign Up/Login_Screen.dart';
import '../Splash, Sign In, Sign Up/Sign_UpScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';


class On_Off_Widget extends StatefulWidget {
  final item;
  final update;
  const On_Off_Widget(this.item, this.update);

  @override
  _On_Off_WidgetState createState() => _On_Off_WidgetState();
}
class _On_Off_WidgetState extends State<On_Off_Widget> {
  late bool isActive;
  late String key;

  @override
  Widget build(BuildContext context) {

    var entryList = widget.item.entries.toList();
    key = entryList[0].key;
    isActive = entryList[0].value;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: cardColor,
        border: Border.all(
          color: isActive ? (cardBorder_On_Color)! : cardBorder_Off_Color,
          width: 3,
        ),
      ),
      height: 150,
      width: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('icons/' + key + '.png'),
                  height: 60,
                  color: isActive ? Colors.deepPurple[200] : Colors.white,
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0)
                .copyWith(left: 15, bottom: 0, top: 5, right: 15),

            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  key,
                  style: GoogleFonts.yantramanav(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: isActive ? Colors.deepPurple[200] : Colors.white,
                    ),
                  ),
                ),
              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  isActive ? "On" : "Off",
                  style: GoogleFonts.yantramanav(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: isActive ? Colors.deepPurple[200] : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Switch(
                  onChanged: (bool value) {
                    setState(() {
                      widget.update(key, value);
                    });
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.deepPurple[200],
                  value: isActive,
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}

class Fire_Data extends StatefulWidget {
  final text;
  const Fire_Data(this.text);

  @override
  _Fire_DataState createState() => _Fire_DataState();
}
class _Fire_DataState extends State<Fire_Data> {

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: cardColor,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.text,
                  style: GoogleFonts.yantramanav(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.deepPurple[200],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),

    );
  }
}


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
            hintText: "Add your name",
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
