import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/services/weather_service.dart';

class WeatherModel extends ChangeNotifier {
  String? city;
  List<String> cities = [
    "Istanbul",
    "Eskisehir",
    "Konya",
    "Izmir",
    "Antalya",
    "Ankara"
  ];

  WeatherModel(this.city);

  void changeCity() {
    int lastIndex = cities.indexOf("Antalya");
    int currentIndex = cities.indexOf(city!);
    if (currentIndex != lastIndex) {
      city = cities[currentIndex + 1];
    } else {
      city = cities[0];
    }
    notifyListeners();
  }

  String getCitiesByIndex(int index) {
    return cities[index];
  }

  Future<void> initState(context) async {
    city ??= cities[0];
    await Provider.of<WeatherService>(context).fetchCurrentWeather(city!);
  }

  Map<String, dynamic>? getCurrentWeather(context) {
    return Provider.of<WeatherService>(context).currentWeather;
  }
}
