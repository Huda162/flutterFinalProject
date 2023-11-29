import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class fetchWeatherData {
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
}