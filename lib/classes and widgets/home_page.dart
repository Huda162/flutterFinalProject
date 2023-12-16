import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/app-drawer.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city-prrovider.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'city-prrovider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  final String title = 'Weather App';


  @override
  Widget build(BuildContext context) {
    String selectedCity = Provider.of<CityProvider>(context).selectedCity;
    return Scaffold(
      appBar: CustomAppBar(context, "Weather App"),
      drawer: AppDrawer(),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchWeatherData().getWeatherData(selectedCity),
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
                  Text('${weatherData['location']['name']}'),
                  CachedNetworkImage(
                    imageUrl: Uri.encodeFull('https:' + weatherData['condition']['icon']),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      print("Error loading image: $error");
                      return Icon(Icons.error);
                    },
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
