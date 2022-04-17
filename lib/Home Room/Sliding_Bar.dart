import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../shared/constants.dart';
import '../shared/Custom_Widgets.dart';



class SlidingBar extends StatefulWidget {

  final ScrollController Scroll_controller;
  final Avatar_Path;
  final name;

  const SlidingBar({Key? key,
    required this.Scroll_controller,
    required this.name,
    required this.Avatar_Path
  }) : super(key: key);

  @override
  _SlidingBarState createState() => _SlidingBarState();
}

class _SlidingBarState extends State<SlidingBar> {

  TextEditingController UserName_Controller = TextEditingController();

  Color Highlighted_color = Color.fromARGB(40,255, 255, 255);
  Color UnHighLighted_color = Colors.transparent;

  Color Avatar1_Color = Colors.transparent;
  Color Avatar2_Color = Colors.transparent;
  Color Avatar3_Color = Colors.transparent;

  String Avatar1_Path = 'icons/vector.png';
  String Avatar2_Path = 'icons/vector2.png';
  String Avatar3_Path = 'icons/vector3.png';

  String Selected_Avatar = "";

  initState()
  {
    setState(() {
      UserName_Controller.text = widget.name;

      if(widget.Avatar_Path == Avatar1_Path)
        Select_Avatar(1);
      else if(widget.Avatar_Path == Avatar2_Path)
        Select_Avatar(2);
      else if(widget.Avatar_Path == Avatar3_Path)
        Select_Avatar(3);

    });
  }

  void Select_Avatar(int number)
  {
    if(number ==1)
      {
        Avatar1_Color = Highlighted_color;
        Avatar2_Color = UnHighLighted_color;
        Avatar3_Color = UnHighLighted_color;

        Selected_Avatar = Avatar1_Path;
      }
    else if(number ==2)
      {
        Avatar2_Color = Highlighted_color;
        Avatar1_Color = UnHighLighted_color;
        Avatar3_Color = UnHighLighted_color;

        Selected_Avatar = Avatar2_Path;
      }
    else if(number ==3)
      {
        Avatar3_Color = Highlighted_color;
        Avatar1_Color = UnHighLighted_color;
        Avatar2_Color = UnHighLighted_color;

        Selected_Avatar = Avatar3_Path;
      }
  }


  Widget Build_Update() {
    return Container(
      alignment: Alignment.center,
      child: ElevatedButton(
        child: Text(
          'Update',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
        style: buttonStyle(Size(250,50)) ,
        onPressed: (){
          update_UserData(Selected_Avatar, UserName_Controller.text);
        },
      ),
    );
  }


  @override
  Widget build(BuildContext context) => ListView(
    padding: EdgeInsets.all(5),
    children: [
      SizedBox(height: 8, width: 0,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("User Settings", style: TextStyle(fontSize: 20, color: Colors.white),),
          SizedBox(height: 0, width: 10,),
          Icon(Icons.arrow_upward,
            color: Colors.deepPurple,
          ),
        ],
      ),
      SizedBox(height: 18,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Image.asset(Avatar1_Path, color: Avatar1_Color, colorBlendMode: BlendMode.multiply),
              iconSize: 80,
              color: Colors.red,
              onPressed: () {
                setState(() {
                  Select_Avatar(1);
                });
              }
          ),
          SizedBox(height: 0, width: 10,),
          IconButton(
              icon: Image.asset(Avatar2_Path, color: Avatar2_Color, colorBlendMode: BlendMode.multiply),
              iconSize: 80,
              onPressed: () {
                setState(() {
                  Select_Avatar(2);
                });
              }
          ),
          SizedBox(height: 0, width: 10,),
          IconButton(
              icon: Image.asset(Avatar3_Path, color: Avatar3_Color, colorBlendMode: BlendMode.multiply),
              iconSize: 80,
              onPressed: () {
                setState(() {
                  Select_Avatar(3);
                });
              }
          ),
        ],
      ),
      SizedBox(height: 20,),
      BuildUserName_Customized(UserName_Controller),
      SizedBox(height: 20,),
      Row(
        children: <Widget>[
          IconButton(onPressed: (){ setState(() {
            Change_Color_Red();
          });  }, icon: const Icon(Icons.circle), color: cardColor_red, ),
          IconButton(onPressed: (){
            setState(() {
              Change_Color_Black();
            });
          }, icon: const Icon(Icons.circle), color: cardColor_blue,),
          IconButton(onPressed: (){
            setState(() {
              Change_Color_Blue();
            });
          }, icon: const Icon(Icons.circle), color: cardColor_orange,),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      SizedBox(height: 20,),
      Build_Update(),
      SizedBox(height: 20,),
      Build_Logout(context),
      SizedBox(height: 25,),
    ],
  );
}





void update_UserData (String AvatarPath, String Name)
{

}