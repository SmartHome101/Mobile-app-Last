import 'dart:convert';
import '../model/weather_module.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {
  Future<Weather> fetchWeather(latitude, longitude) async {
    final response;

    if (latitude != null) {
      response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=0fb27f9d286ec3ad117cb6b584aac7ae'));
    } else {
      response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=zagazig&appid=0fb27f9d286ec3ad117cb6b584aac7ae'));
    }
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load Weather');
    }
  }
}
