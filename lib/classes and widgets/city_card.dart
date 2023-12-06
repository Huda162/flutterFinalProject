import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';

class CityCard extends StatelessWidget {
  final String city;

  const CityCard({Key? key, required this.city}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchWeatherData().getWeatherData(city),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          Map<String, dynamic> weatherData = snapshot.data!;
          return Container(
            padding: EdgeInsets.all(8.0), // Adjust padding as needed
            child: Card(
              child: ListTile(
                leading: Image.network(
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
            ),
          );
        }
      },
    );
  }
}
