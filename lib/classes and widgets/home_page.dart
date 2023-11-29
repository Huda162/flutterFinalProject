import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = 'Weather App';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<String>> futureWeatherData;
  fetchWeatherData weatherData = fetchWeatherData();

  @override
  void initState(){
    super.initState();
    futureWeatherData = weatherData.getWeatherData("London");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
              onSelected: (value){
                if(value == "cities"){
                  Navigator.pushNamed(context, '/CitiesWeather');
                }
                else if (value == "hourly"){
                  Navigator.pushNamed(context, '/HourlyWeather');
                }
                else if(value=="daily"){
                  Navigator.pushNamed(context, '/DailyWeather');
                }
              },
              itemBuilder: (BuildContext context){
                return <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    child: Text("Cities Weather"),
                    value: 'cities',),
                  PopupMenuItem<String>(
                    child: Text("Daily Weather"),
                    value: 'daily',),
                  PopupMenuItem<String>(
                    child: Text("Hourly Weather"),
                    value: 'hourly',)
                ];
              })
        ],
      ),
      body: FutureBuilder(
        future: futureWeatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<String> weatherData = snapshot.data as List<String>;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${weatherData[0]}'),
                  Icon(Icons.sunny),
                  Text('${weatherData[1]}°C'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}