import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class fetchWeatherData {
  static const String apiKey = "4d388933befa4a77910101931232611";
  static const String baseUrl = "https://api.weatherapi.com/v1";
  Future<List<String>> getWeatherData(location) async{
    final apiUrl = "$baseUrl/current.json?key=$apiKey&q=$location&aqi=no";
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

  Future<List<Map<String, dynamic>>> getDailyWeatherData(location) async {
    final apiUrl = "$baseUrl/forecast.json?key=$apiKey&q=$location&aqi=no&days=6";
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
}