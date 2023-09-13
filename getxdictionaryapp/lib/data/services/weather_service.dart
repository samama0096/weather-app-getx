import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = '951cc1c7380cd3aa1d0f9bf9735019f1';

  Future<Weather> getWeather(String city) async {
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather(
        city: data['name'],
        description: data['weather'][0]['description'],
        temperature: data['main']['temp'],
        humidity: data['main']['humidity'],
      );
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
