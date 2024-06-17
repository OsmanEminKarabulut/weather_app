import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/model/weather_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<WeatherModel>(context).initState(context);
    var weatherData =
        Provider.of<WeatherModel>(context).getCurrentWeather(context);

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/background.png"))),
        ),
        TemperatureWidget(weatherData: weatherData),
        const OtherCitiesWidget()
      ],
    ));
  }
}

class TemperatureWidget extends StatelessWidget {
  const TemperatureWidget({super.key, required this.weatherData});
  final Map<String, dynamic>? weatherData;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            weatherData?["data"][0]["temp"].toString() ?? "-",
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white, fontSize: 80),
          ),
          Text(
            Provider.of<WeatherModel>(context).city.toString(),
            style: Theme.of(context)
                .textTheme
                .headlineLarge
                ?.copyWith(color: Colors.white, fontSize: 80),
          )
        ],
      ),
    );
  }
}

class OtherCitiesWidget extends StatelessWidget {
  const OtherCitiesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 0,
      child: IconButton(
        icon: Image.asset("assets/images/icons/Hover2.png"),
        onPressed: () {
          Provider.of<WeatherModel>(context, listen: false).changeCity();
        },
      ),
    );
  }
}
