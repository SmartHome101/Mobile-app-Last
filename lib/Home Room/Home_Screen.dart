import 'dart:async';
import 'dart:convert';
import 'dart:ffi';

import 'package:Home/Rooms/BedRoom.dart';
import 'package:Home/Rooms/Kitchen.dart';
import 'package:Home/Rooms/LivingRoom.dart';
import 'package:Home/Rooms/Reception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../Controllers/authentication_servies.dart';
import '../Controllers/weather_api_client.dart';
import '../Rooms/Bathroom.dart';
import '../model/weather_module.dart';
import '../shared/Custom_Widgets.dart';
import '../shared/constants.dart';
import '../Controllers/shared_preferences.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var Home_Code;

class _HomePageState extends State<HomePage> {
  WeatherApiClient client = WeatherApiClient();
  Weather? data;

  var dataBase;
  bool isLoading = false;

  String Rain_Level = "";

  FirebaseFirestore db = FirebaseFirestore.instance;

  String CurrentAvatar = 'icons/vector.png';

  TextEditingController UserName_Controller = TextEditingController();

  PanelController panalController = new PanelController();

  Color Highlighted_color = Color.fromARGB(40, 255, 255, 255);
  Color UnHighLighted_color = Colors.transparent;

  Color Avatar1_Color = Colors.transparent;
  Color Avatar2_Color = Colors.transparent;
  Color Avatar3_Color = Colors.transparent;

  Color Color1_BoarderColor = Colors.transparent;
  Color Color2_BoarderColor = Colors.transparent;

  String Avatar1_Path = 'icons/vector.png';
  String Avatar2_Path = 'icons/vector2.png';
  String Avatar3_Path = 'icons/vector3.png';

  String Selected_Avatar = "";

  int Selected_Color = 1;

  var userName_Validator = "";

  final recorder = FlutterSoundRecorder();
  late String filePath;
  late StreamSubscription<List<int>> responseStream;
  dynamic _body;
  var location;

  Future record() async {
    await recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );
  }

  Future stop() async {
    await recorder.stopRecorder();
    final file = File(filePath);

    await uploadFiles();
  }

  uploadFiles() async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://sr.techome.systems/predict'));

    var audio = await http.MultipartFile.fromPath('file', filePath);
    request.files.add(audio);

    var response = await request.send();

    print(response.statusCode);
    final res = await http.Response.fromStream(response);
    print(res.body);
  }

  Future initRecorder() async {
    filePath = '/sdcard/Download/temp.wav';

    final status = await Permission.microphone.request();
    await Permission.storage.request();
    await Permission.manageExternalStorage.request();

    if (status != PermissionStatus.granted) throw 'Microphone not granted';

    await recorder.openRecorder();

    recorder.setSubscriptionDuration(const Duration(milliseconds: 500));
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    location = await Geolocator.getCurrentPosition();
    // return await Geolocator.getCurrentPosition();
  }

  initState() {
    super.initState();

    setState(() {
      CurrentAvatar = "icons/vector.png";

      if (CurrentAvatar == Avatar1_Path)
        Select_Avatar(1);
      else if (CurrentAvatar == Avatar2_Path)
        Select_Avatar(2);
      else if (CurrentAvatar == Avatar3_Path) Select_Avatar(3);

      GetColor();
    });

    initRecorder();
    _determinePosition();
  }

  Future<void> getWeatherData() async {
    data = await client.fetchWeather(location.latitude, location.longitude);
  }

  GetColor() async {
    Selected_Color = await CacheHelper.getData(key: "color");

    setState(() {
      if (Selected_Color == 1 || Selected_Color == 0) {
        Change_Color("Black");
        Selected_Color = 1;
      } else if (Selected_Color == 2) Change_Color("White");

      Select_Color(Selected_Color);
    });
  }

  getRainStatus() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref(Home_Code);
    DatabaseEvent event = await ref.once();

    dataBase = event.snapshot.value as Map;
    Rain_Level = dataBase["Rain level"];

    Stream<DatabaseEvent> stream = ref.onValue;
    stream.listen((DatabaseEvent event) {
      if (!mounted) return;

      dataBase = event.snapshot.value as Map;
      var newRainLevel = dataBase["Rain level"];

      if (newRainLevel == Rain_Level) return;

      setState(() {
        Rain_Level = newRainLevel;
      });
    });
  }

  void Select_Avatar(int number) {
    if (number == 1) {
      Avatar1_Color = Highlighted_color;
      Avatar2_Color = UnHighLighted_color;
      Avatar3_Color = UnHighLighted_color;

      Selected_Avatar = Avatar1_Path;
    } else if (number == 2) {
      Avatar2_Color = Highlighted_color;
      Avatar1_Color = UnHighLighted_color;
      Avatar3_Color = UnHighLighted_color;

      Selected_Avatar = Avatar2_Path;
    } else if (number == 3) {
      Avatar3_Color = Highlighted_color;
      Avatar1_Color = UnHighLighted_color;
      Avatar2_Color = UnHighLighted_color;

      Selected_Avatar = Avatar3_Path;
    }
  }

  void Select_Color(int number) {
    if (number == 1) {
      Color1_BoarderColor = Highlighted_color;
      Color2_BoarderColor = UnHighLighted_color;

      Change_Color("Black");
    } else if (number == 2) {
      Color2_BoarderColor = Highlighted_color;
      Color1_BoarderColor = UnHighLighted_color;
      Change_Color("White");
    }
    Selected_Color = number;

    CacheHelper.saveData(key: "color", value: number);
  }

  String Get_WeatherImage() {
    String rainLevel_Modifed = Rain_Level.replaceAll(" ", "");
    String path;

    if (rainLevel_Modifed == "Heavy") {
      path = 'icons/temp_highRain.png';
    } else if ((rainLevel_Modifed == "Moderate") ||
        (rainLevel_Modifed == "Light")) {
      path = 'icons/temp_lowRain.png';
    } else if (data!.temp.round() > 25) {
      path = 'icons/temp_high.png';
    } else {
      path = 'icons/temp_low.png';
    }

    return path;
  }

  String Get_Rain_Text() {
    String rainLevel_Modifed = Rain_Level.replaceAll(" ", "");

    if (rainLevel_Modifed == "") {
      return "";
    } else {
      return ("   " + Rain_Level + "\n Rain Level");
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    String? displayName = firebaseUser?.displayName ?? "User";
    String? photoURL = firebaseUser?.photoURL ?? "icons/vector.png";
    UserName_Controller.text = displayName;

    getHomeCode() async {
      final docRef = db.collection("users").doc(firebaseUser!.uid);
      DocumentSnapshot doc = await docRef.get();
      final data = doc.data() as Map;

      Home_Code = data["code"];

      return data["code"];
    }

    final List<Map> _listItem = [
      {
        "img": "icons/reception.png",
        "name": "reception",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Reception();
          }));
        }
      },
      {
        "img": "icons/living_room.png",
        "name": "Living Room",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return LivingRoom();
          }));
        }
      },
      {
        "img": "icons/kitchen.png",
        "name": "Kitchen",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Kitchen();
          }));
        }
      },
      {
        "img": "icons/bathroom.png",
        "name": "Bathroom",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Bathroom();
          }));
        }
      },
      {
        "img": "icons/bedroom.png",
        "name": "Bed Room",
        "onPress": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BedRoom();
          }));
        }
      },
    ];

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 10,
          toolbarHeight: 60,
          backgroundColor: cardColor,
          bottom: PreferredSize(
              child: Container(
                color: Colors.white12,
                height: 4.0,
              ),
              preferredSize: Size.fromHeight(4.0)),
          leading: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: new SizedBox(
                height: 25.0,
                width: 18.0,
                child: IconButton(
                  icon: Image.asset(photoURL),
                  iconSize: 150,
                  onPressed: () {
                    if (panalController.isPanelOpen)
                      panalController.close();
                    else
                      panalController.open();
                  },
                ),
              )),
          title: Text(
            'Hello ' + displayName,
            style: TextStyle(
              color: foregroundColor,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: [
            Row(children: [
              StreamBuilder<RecordingDisposition>(
                stream: recorder.onProgress,
                builder: (context, snapshot) {
                  final duration = snapshot.hasData
                      ? snapshot.data!.duration
                      : Duration.zero;
                  return Text(
                    recorder.isRecording ? "${duration.inSeconds} s" : "",
                    style: TextStyle(
                      color: foregroundColor,
                      fontStyle: FontStyle.italic,
                    ),
                  );
                },
              ),
            ]),
            IconButton(
              icon: Icon(recorder.isRecording
                  ? Icons.stop_circle
                  : Icons.mic_outlined),
              iconSize: 35,
              onPressed: () async {
                if (recorder.isRecording) {
                  await stop();
                } else {
                  await record();
                }

                setState(() {});
              },
            ),
            SizedBox(
              height: 20.0,
              width: 20.0,
            )
          ],
        ),
        body: SlidingUpPanel(
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 15, 25, 5),
              decoration: Background_decoration(),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    height: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: cardColor,
                      boxShadow: [
                        BoxShadow(
                          color: shadowColor,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: FutureBuilder(
                      future: _determinePosition(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return FutureBuilder(
                            future: getWeatherData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return FutureBuilder(
                                    future: getHomeCode(),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return FutureBuilder(
                                            future: getRainStatus(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                return Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  textBaseline:
                                                      TextBaseline.alphabetic,
                                                  children: <Widget>[
                                                    Transform.scale(
                                                      scale: 1.4,
                                                      child: Image(
                                                        image: AssetImage(
                                                            Get_WeatherImage()),
                                                        width: 180,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 22,
                                                      width: 30,
                                                    ),
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        textBaseline:
                                                            TextBaseline
                                                                .alphabetic,
                                                        children: <Widget>[
                                                          Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  data!.temp
                                                                      .round()
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color:
                                                                          foregroundColor,
                                                                      fontSize:
                                                                          50,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                                const Text(
                                                                  'o',
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        foregroundColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        'OpenSans',
                                                                  ),
                                                                ),
                                                              ]),
                                                          Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              textBaseline:
                                                                  TextBaseline
                                                                      .alphabetic,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  Get_Rain_Text(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .deepPurpleAccent,
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ]),
                                                        ]),
                                                  ],
                                                );
                                              } else {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }
                                            });
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                    });
                              } else {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              // By default, show a loading spinner.
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Expanded(
                      child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 15,
                    scrollDirection: Axis.vertical,
                    children: _listItem
                        .map((item) => GestureDetector(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: cardColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: shadowColor,
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      item['img'],
                                      height: 75,
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
                  )),
                  const SizedBox(
                    height: 145,
                  ),
                ],
              ),
            ),
          ),
          controller: panalController,
          color: cardColor,
          minHeight: 55,
          maxHeight: 430,
          border: Border.all(width: 2.0, color: Colors.white10),
          borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
          panelBuilder: (controller) => ListView(
            padding: EdgeInsets.all(5),
            children: [
              SizedBox(
                height: 8,
                width: 0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "User Settings",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 0,
                    width: 10,
                  ),
                  Icon(
                    Icons.arrow_upward,
                    color: Colors.deepPurple,
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: Image.asset(Avatar1_Path,
                          color: Avatar1_Color,
                          colorBlendMode: BlendMode.multiply),
                      iconSize: 80,
                      color: Colors.red,
                      onPressed: () {
                        setState(() {
                          Select_Avatar(1);
                        });
                      }),
                  SizedBox(
                    height: 0,
                    width: 10,
                  ),
                  IconButton(
                      icon: Image.asset(Avatar2_Path,
                          color: Avatar2_Color,
                          colorBlendMode: BlendMode.multiply),
                      iconSize: 80,
                      onPressed: () {
                        setState(() {
                          Select_Avatar(2);
                        });
                      }),
                  SizedBox(
                    height: 0,
                    width: 10,
                  ),
                  IconButton(
                      icon: Image.asset(Avatar3_Path,
                          color: Avatar3_Color,
                          colorBlendMode: BlendMode.multiply),
                      iconSize: 80,
                      onPressed: () {
                        setState(() {
                          Select_Avatar(3);
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              BuildUserName_Customized(UserName_Controller, displayName),
              SizedBox(
                height: 5,
              ),
              Row(
                children: <Widget>[
                  Text(
                    userName_Validator,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              SizedBox(
                height: 1,
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Image.asset('icons/color1.png',
                        color: Color1_BoarderColor,
                        colorBlendMode: BlendMode.multiply),
                    onPressed: () {
                      setState(() {
                        Select_Color(1);
                      });
                    },
                  ),
                  IconButton(
                    icon: Image.asset('icons/color2.png',
                        color: Color2_BoarderColor,
                        colorBlendMode: BlendMode.multiply),
                    onPressed: () {
                      setState(() {
                        Select_Color(2);
                      });
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
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
                  style: buttonStyle(Size(250, 50)),
                  onPressed: () async {
                    if (UserName_Controller.text.length < 4) {
                      setState(() {
                        userName_Validator =
                            "Your user name must be at least 4 letters";
                      });
                    } else {
                      setState(() {
                        userName_Validator = "";
                        isLoading = true;
                      });
                      await context.read<AuthenticationService>().updateUser(
                          fullName: UserName_Controller.text,
                          photoURL: Selected_Avatar);
                      setState(() {
                        isLoading = false;
                      });
                    }

                    // update_UserData(
                    //     Selected_Avatar, UserName_Controller.text, Selected_Color);
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Build_Logout(context),
              SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
