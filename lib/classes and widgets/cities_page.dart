import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';

class CitiesWeatherPage extends StatefulWidget {
  const CitiesWeatherPage({super.key});

  @override
  State<CitiesWeatherPage> createState() => _CitiesWeatherState();
}

Set<String> cities = {
  "Jerusalem", "London", "Paris"
};

class _CitiesWeatherState extends State<CitiesWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cities Weather"),
        actions: [
          PopupMenuButton(onSelected: (value) {
            if (value == "cities") {
              Navigator.pushNamed(context, '/CitiesWeather');
            } else if (value == "hourly") {
              Navigator.pushNamed(context, '/HourlyWeather');
            } else if (value == "daily") {
              Navigator.pushNamed(context, '/DailyWeather');
            }
          }, itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                child: Text("Cities Weather"),
                value: 'cities',
              ),
              PopupMenuItem<String>(
                child: Text("Daily Weather"),
                value: 'daily',
              ),
              PopupMenuItem<String>(
                child: Text("Hourly Weather"),
                value: 'hourly',
              )
            ];
          })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            CityCard(city: "London"),
            CityCard(city: "Jerusalem"),
            CityCard(city: "Cairo"),
            CityCard(city: "Paris"),
          ],
        ),
      ),
    );
  }
}
