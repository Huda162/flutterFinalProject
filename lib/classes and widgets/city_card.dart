import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';



class CityCard extends StatefulWidget {
  const CityCard({super.key, String? city} );

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  late Future<List<String>> futureWeatherData;
  fetchWeatherData weatherData = fetchWeatherData();

  @override
  void initState(){
    super.initState();
    // futureWeatherData = weatherData.getWeatherData();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}