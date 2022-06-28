class Weather {
  final double temp;

  const Weather({required this.temp});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      temp: json['main']['temp'] - 273.15,
    );
  }
}
