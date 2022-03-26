import 'package:flutter/material.dart';
import 'package:smart_home_app/Splash,%20Sign%20In,%20Sign%20Up/Login_Screen.dart';
import '../Rooms/living_room.dart';

// String GetName() {
//   return ;
// }

class HomePage extends StatefulWidget {
  final userName;
  const HomePage(this.userName);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int temp = 40;
  @override
  Widget build(BuildContext context) {
    final List<Map> _listItem = [
      {"img": "icons/kitchen.png", "name": "Kitchen", "onPress": () {}},
      {"img": "icons/bathroom.png", "name": "Bathroom", "onPress": () {}},
      {
        "img": "icons/living_room.png",
        "name": "Living Room",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LivingRoom();
          }));
        }
      },
      {"img": "icons/bedroom.png", "name": "Bed Room", "onPress": () {}},
      {
        "img": "icons/washing_room.png",
        "name": "Waching Room",
        "onPress": () {}
      },
      {"img": "icons/studio.png", "name": "Studio", "onPress": () {}},
    ];
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF0A0E21),
        leading: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Image(
            image: AssetImage('icons/vector.png'),
          ),
        ),
        title: Text('Hello ' + widget.userName),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginScreen();
                }));
              },
              child: const Icon(
                IconData(0xe3b3, fontFamily: 'MaterialIcons'),
                color: Color(0xFF6F35A5),
              )),
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xFF1D1E33),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Transform.scale(
                      scale: 1.3,
                      child: Image(
                        image: AssetImage(temp > 30
                            ? 'assets/images/temp_high.png'
                            : 'assets/images/temp_low.png'),
                        width: 180,
                      ),
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          Text(
                            temp.toString(),
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 50,
                                fontWeight: FontWeight.w900),
                          ),
                          const Text(
                            'c',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ]),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: _listItem
                    .map((item) => GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF1D1E33),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item['img'],
                                  height: 90,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  item['name'],
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'OpenSans',
                                  ),
                                )
                              ],
                            ),
                          ),
                          onTap: item['onPress'],
                        ))
                    .toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
