class Weather {
  final double temp;
  final String description;

  const Weather({required this.temp, required this.description});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'] - 273.15,
      description: json['weather'][0]['description'],
    );
  }
}
