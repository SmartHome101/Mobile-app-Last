import 'package:Home/model/nlp_module.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../Controllers/food_api_client.dart';
import '../Controllers/nlp_api_client.dart';
import '../Controllers/sr_api_client.dart';
import '../Controllers/weather_api_client.dart';
import '../model/food_recipe_module.dart';
import '../model/weather_module.dart';
import '../shared/Custom_Widgets.dart';
import '../shared/constants.dart';

class VoiceAssistant extends StatefulWidget {
  const VoiceAssistant({Key? key}) : super(key: key);

  @override
  State<VoiceAssistant> createState() => _VoiceAssistantState();
}

class _VoiceAssistantState extends State<VoiceAssistant> {
  final recorder = FlutterSoundRecorder();
  late String filePath;

  String searchTopic = "";

  String ingredients = "";
  String instructions = "";

  SRApiClient srClient = SRApiClient();
  String? srResult;

  NLPApiClient nlpClient = NLPApiClient();
  NLPResult? nlpResult;

  FoodApiClient foodClient = FoodApiClient();
  FoodRecipe? foodResult;

  WeatherApiClient client = WeatherApiClient();
  Weather? weatherData;

  Future record() async {
    srResult = null;
    searchTopic = "";
    weatherData = null;
    ingredients = "";
    instructions = "";

    await recorder.startRecorder(
      toFile: filePath,
      codec: Codec.pcm16WAV,
    );
  }

  Future stop() async {
    await recorder.stopRecorder();
    setState(() {});

    await processVoice();
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

  processVoice() async {
    srResult = await srClient.uploadAudio(filePath);

    setState(() {});

    if (srResult!.length > 1) {
      nlpResult = await nlpClient.getTextResult(srResult);

      if (nlpResult!.Intent == "Cooking") {
        searchTopic = "I Searched for " + nlpResult!.Entity + " recipe";

        foodResult = await foodClient.getFoodRecipe(nlpResult!.Entity);

        ingredients = foodResult!.ingredients;
        instructions = foodResult!.instructions;
      } else if (nlpResult!.Intent == "Weather") {
        searchTopic = "I Searched for " + nlpResult!.Entity + " weather status";

        weatherData = await client.fetchWeather(nlpResult!.Entity, null);
      } else {
        searchTopic = "Sorry, I didn't understand you ☹️";
      }
    } else {
      searchTopic = "Sorry, I didn't understand you ☹️";
    }
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    initRecorder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: cardColor,
        shadowColor: shadowColor,
        title: const Text("Techome Leo"),
        elevation: 10,
        toolbarHeight: 60,
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: Background_decoration(),
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 10),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Text(
                  "Search for a food recipe or weather status",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                IconButton(
                  icon: Icon(recorder.isRecording
                      ? Icons.stop_circle
                      : Icons.mic_outlined),
                  iconSize: 55,
                  color: Colors.white,
                  onPressed: () async {
                    if (recorder.isRecording) {
                      await stop();
                    } else {
                      await record();
                    }

                    setState(() {});
                  },
                ),
                StreamBuilder<RecordingDisposition>(
                  stream: recorder.onProgress,
                  builder: (context, snapshot) {
                    final duration = snapshot.hasData
                        ? snapshot.data!.duration
                        : Duration.zero;
                    return Text(
                      recorder.isRecording ? "${duration.inSeconds} s" : "",
                      style: const TextStyle(
                        color: foregroundColor,
                        fontStyle: FontStyle.italic,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  srResult != null ? "You said \n $srResult" : "",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: foregroundColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  searchTopic,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: foregroundColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  ingredients.isNotEmpty ? "Ingredients: \n$ingredients" : "",
                  style: const TextStyle(
                    fontSize: 18,
                    color: foregroundColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  instructions.isNotEmpty
                      ? "Instructions: \n$instructions"
                      : "",
                  style: const TextStyle(
                    fontSize: 18,
                    color: foregroundColor,
                  ),
                ),
                Text(
                  weatherData != null
                      ? "Tempreature is : ${weatherData!.temp.round()}°C"
                      : "",
                  style: const TextStyle(
                    fontSize: 16,
                    color: foregroundColor,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  weatherData != null
                      ? "Weather description is : ${weatherData!.description}"
                      : "",
                  style: const TextStyle(
                    fontSize: 16,
                    color: foregroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
