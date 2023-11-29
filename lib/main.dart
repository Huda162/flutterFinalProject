import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        '/CitiesWeather': (context) => CitiesWeatherPage(),
        '/HourlyWeather': (context) => HourlyWeatherPage(),
        '/DailyWeather': (context) => DailyWeatherPage()
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  final String title = 'Weather App';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<String>> futureWeatherData;
  static const String apiKey = "4d388933befa4a77910101931232611";
  static const String baseUrl = "https://api.weatherapi.com/v1/current.json";
  Future<List<String>> getWeatherData(location) async{
    final apiUrl = "$baseUrl?key=$apiKey&q=$location&aqi=no";
    http.Response response = await http.get(Uri.parse(apiUrl));
    print(response.statusCode);
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      List<String> resultList = [data['location']['name'], data['current']['temp_c'].toString()];
      Future<List<String>> futureResultList = Future.value(resultList);
      return futureResultList;
    }
    else{
      throw Exception("Failed to load data from API");
    }
  }

  @override
  void initState(){
    super.initState();
    futureWeatherData = getWeatherData("London");
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


class CitiesWeatherPage extends StatefulWidget {
  const CitiesWeatherPage({super.key});

  @override
  State<CitiesWeatherPage> createState() => _CitiesWeatherState();
}

class _CitiesWeatherState extends State<CitiesWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class HourlyWeatherPage extends StatefulWidget {
  const HourlyWeatherPage({super.key});

  @override
  State<HourlyWeatherPage> createState() => _HourlyWeatherState();
}

class _HourlyWeatherState extends State<HourlyWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class DailyWeatherPage extends StatefulWidget {
  const DailyWeatherPage({super.key});

  @override
  State<DailyWeatherPage> createState() => _DailyWeatherState();
}

class _DailyWeatherState extends State<DailyWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

