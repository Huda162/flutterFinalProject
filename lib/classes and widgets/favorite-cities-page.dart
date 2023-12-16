
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city_card.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'package:flutter_final_project/classes%20and%20widgets/home_page.dart';
import 'CustomAppBar.dart';
import 'app-drawer.dart';
import 'package:provider/provider.dart';
import 'city-prrovider.dart';
import 'city-database.dart';
import 'city.dart';

class FavoriteCitiesWeatherPage extends StatefulWidget {
  FavoriteCitiesWeatherPage({Key? key});


  @override
  State<FavoriteCitiesWeatherPage> createState() => _FavoriteCitiesWeatherPageState();
}

class _FavoriteCitiesWeatherPageState extends State<FavoriteCitiesWeatherPage> {
  List<String> favoriteCities = [];


  @override
  void initState() {
    super.initState();
    initializeFavoriteCities();
  }

  Future<void> initializeFavoriteCities() async {
    List<City> allCities = await DatabaseProvider.instance.getAllCities();
    setState(() {
      favoriteCities = allCities.map((city) => city.name).toList();
    });
  }

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
      appBar: CustomAppBar(context, "Favorite Cities Weather"),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: favoriteCities.length,
        itemBuilder: (context, index) {
          return FutureBuilder<Map<String, dynamic>>(
            future: fetchWeatherData().getWeatherData(favoriteCities[index]),
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
                        .changeSelectedCity(favoriteCities[index]);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  leading: CachedNetworkImage(
                    imageUrl: Uri.encodeFull('https:' + weatherData['condition']['icon']),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) {
                      print("Error loading image: $error");
                      return Icon(Icons.error);
                    },
                  ),
                  title: Text(
                    '${weatherData['location']['name']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  subtitle: Column(
                    children: [Text(
                      '${weatherData['condition']['text']}  '
                          '${weatherData['temperature']}°C',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey,
                      ),
                    ),
                      ],
                  ),
                  trailing:
                      ElevatedButton(
                        onPressed: () {
                          showCityDialog(context, favoriteCities[index], weatherData);
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
