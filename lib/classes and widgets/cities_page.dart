import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city_card.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';
import 'app-drawer.dart';

class CitiesWeatherPage extends StatelessWidget {
   CitiesWeatherPage({Key? key});

  Set<String> cities = {"Jerusalem", "London", "Paris", "Amman"};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Cities Weather"),
      drawer: AppDrawer(),
      body: Container(
        child: Column(
          children: cities
              .map((city) => CityCard(city: city))
              .toList(), // Use the map function to create CityCard widgets for each city
        ),
      ),
    );
  }
}
