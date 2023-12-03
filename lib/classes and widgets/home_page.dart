import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/app-drawer.dart';
import 'package:flutter_final_project/classes%20and%20widgets/cities_page.dart';
import 'package:flutter_final_project/classes%20and%20widgets/daily_weather_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';
import 'app-drawer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = 'Weather App';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  late Future<Map<String, dynamic>> futureWeatherData;
  fetchWeatherData weatherData = fetchWeatherData();

  @override
  void initState(){
    super.initState();
    futureWeatherData = weatherData.getWeatherData("London");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Weather App"),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: futureWeatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic>weatherData = snapshot.data!;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${weatherData['location']}'),
                  Image.network(
                    weatherData['condition']['icon'],
                    width: 100,
                    height: 100,
                  ),
                  Text('${weatherData['temperature']}°C'),
                  Text('${weatherData['condition']['text']}'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}