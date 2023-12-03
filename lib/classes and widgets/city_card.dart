import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';



class CityCard extends StatefulWidget {
  final String city;
  const CityCard({Key? key, required this.city}) : super(key: key);

  @override
  State<CityCard> createState() => _CityCardState(city: city);
}

class _CityCardState extends State<CityCard> {
  late Future< Map<String, dynamic>> futureWeatherData;
  fetchWeatherData weatherData = fetchWeatherData();
  final String city;

  _CityCardState({required this.city});

  @override
  void initState() {
    super.initState();
    futureWeatherData = weatherData.getWeatherData(city);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0), // Adjust padding as needed
      child: FutureBuilder(
        future: futureWeatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> weatherData = snapshot.data!;
            return Card(
              child: ListTile(
                leading:  Image.network(
                  weatherData['condition']['icon'],
                  width: 50.0,
                  height: 50.0,
                ),
                title: Text(
                  '${weatherData['location']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                subtitle: Text(
                  '${weatherData['condition']['text']}  '

                  '${weatherData['temperature']}°C',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

