import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/classes and widgets/cities_page.dart';
import 'package:flutter_final_project/classes and widgets/home_page.dart';

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

