import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city_card.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';
import 'app-drawer.dart';

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
      appBar: CustomAppBar("Cities Weather"),
      drawer: AppDrawer(),
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
