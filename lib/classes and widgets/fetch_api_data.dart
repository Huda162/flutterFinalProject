import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class fetchWeatherData {
  static const String apiKey = "4d388933befa4a77910101931232611";
  static const String baseUrl = "https://api.weatherapi.com/v1";
  Future<Map<String, dynamic>> getWeatherData(location) async{
    final apiUrl = "$baseUrl/current.json?key=$apiKey&q=$location&aqi=no";
    http.Response response = await http.get(Uri.parse(apiUrl));
    print(response.statusCode);
    if (response.statusCode == 200){
      final data = jsonDecode(response.body);
      Map<String, dynamic> result = {
        'location': data['location']['name'],
        'temperature': data['current']['temp_c'].toString(),
        'condition': {
          'text': data['current']['condition']['text'],
          'icon': data['current']['condition']['icon'],
          'code': data['current']['condition']['code'],
        },
      };
      return result;
    }
    else{
      throw Exception("Failed to load data from API");
    }
  }

  Future<List<Map<String, dynamic>>> getDailyWeatherData(location) async {
    final apiUrl = "$baseUrl/forecast.json?key=$apiKey&q=$location&aqi=no&days=7";
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> dailyForecasts = data['forecast']['forecastday'];
      List<Map<String, dynamic>> forecasts = [];

      for (var forecast in dailyForecasts) {
        forecasts.add({
          'date': DateTime.parse(forecast['date']),
          'maxTemperature': forecast['day']['maxtemp_c'],
          'minTemperature': forecast['day']['mintemp_c'],
          'averageTemperature': forecast['day']['avgtemp_c'],
          'condition': {
            'text': forecast['day']['condition']['text'],
            'icon': forecast['day']['condition']['icon'],
            'code': forecast['day']['condition']['code'],
          },
          'uvIndex': forecast['day']['uv'],
        });
      }

      return forecasts;
    } else {
      throw Exception("Failed to load data from API");
    }
  }
  Future<List<Map<String, dynamic>>> getHourlyWeatherData(location) async {
    String currentTime = DateTime.now().toString().substring(11,13);
    print(currentTime);
    final apiUrl = "$baseUrl/forecast.json?key=$apiKey&q=$location&aqi=no&hours=24";
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> hourlyForecasts = data['forecast']['forecastday'][0]['hour'];
      List<Map<String, dynamic>> forecasts = [];

      for (var forecast in hourlyForecasts) {
        forecasts.add({
          'time': forecast['time'],
          'temperature': forecast['temp_c'],
          'condition': {
            'text': forecast['condition']['text'],
            'icon': forecast['condition']['icon'],
            'code': forecast['condition']['code'],
          },
          'windSpeed': forecast['wind_kph'],
        });
      }

      return forecasts;
    } else {
      throw Exception("Failed to load data from API");
    }
  }
}