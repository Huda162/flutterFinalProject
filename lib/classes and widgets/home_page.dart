import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/app-drawer.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  final String title = 'Weather App';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Weather App"),
      drawer: AppDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchWeatherData().getWeatherData("Jerusalem"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> weatherData = snapshot.data!;
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
