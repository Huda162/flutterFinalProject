import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city_card.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'package:flutter_final_project/classes%20and%20widgets/home_page.dart';
import 'CustomAppBar.dart';
import 'app-drawer.dart';
import 'package:provider/provider.dart';
import 'city-prrovider.dart';

class CitiesWeatherPage extends StatelessWidget {
  CitiesWeatherPage({Key? key});

  List<String> cities = ["Jerusalem", "London", "Paris", "Amman"];

  void showCityDialog(
      BuildContext context, String city, Map<String, dynamic> weatherData) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(city),
              content: SingleChildScrollView(
                  child: Container(
                child: Column(children: [
                  Text("city: ${weatherData['location']['country']}"),
                  Text("localtime: ${weatherData['location']['localtime']}")
                ]),
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Cities Weather"),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Map<String, dynamic>>(
            future: fetchWeatherData().getWeatherData(cities[index]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                Map<String, dynamic> weatherData = snapshot.data!;
                return ListTile(
                  onTap: () {
                    Provider.of<CityProvider>(context, listen: false)
                        .changeSelectedCity(cities[index]);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  leading: Image.network(
                    weatherData['condition']['icon'],
                    width: 50.0,
                    height: 50.0,
                  ),
                  title: Text(
                    '${weatherData['location']['name']}',
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
                  trailing: ElevatedButton(
                    onPressed: () {
                      showCityDialog(context, cities[index], weatherData);
                    },
                    child: Text("Show Details"),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
