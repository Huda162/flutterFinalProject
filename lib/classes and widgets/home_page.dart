import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/app-drawer.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city-prrovider.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';
import 'package:provider/provider.dart';
import 'city-prrovider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String selectedCity = Provider.of<CityProvider>(context).selectedCity;
    return Scaffold(
      appBar: CustomAppBar(context, "Weather App"),
      drawer: AppDrawer(),
      body: Center(
        child:
          FutureBuilder<Map<String, dynamic>>(
            future: fetchWeatherData().getWeatherData(selectedCity),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                Map<String, dynamic> weatherData = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${weatherData['location']['name']}',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      CachedNetworkImage(
                        imageUrl: Uri.encodeFull('https:' + weatherData['condition']['icon']),
                        placeholder: (context, url) => CircularProgressIndicator(),
                        errorWidget: (context, url, error) {
                          print("Error loading image: $error");
                          return Icon(Icons.error);
                        },
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        '${weatherData['temperature']}°C',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '${weatherData['condition']['text']}',
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey,
                        ),

                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: (){setState(() {

                        });},
                        child: Text('Reload Data'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),

      ),
    );
  }
}
