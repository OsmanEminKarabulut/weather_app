import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService extends ChangeNotifier {
  static const baseUrl = "https://api.weatherbit.io/v2.0";

  Map<String, dynamic>? _currentWeather;

  WeatherService(this.apiKey);
  Map<String, dynamic>? get currentWeather => _currentWeather;

  final String apiKey;

  Future fetchCurrentWeather(String city) async {
    final String apiUrl = "$baseUrl/current?city=$city&key=$apiKey";

    final response = await http.get(Uri.parse(apiUrl));

    try {
      if (response.statusCode == 200) {
        _currentWeather = json.decode(response.body);
        notifyListeners();
      } else {
        throw Exception("Failed to load current weather");
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
      throw Exception("Failed to load current weather");
    }
  }
}
