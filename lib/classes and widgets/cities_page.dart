
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

class CitiesWeatherPage extends StatefulWidget {
  CitiesWeatherPage({Key? key});


  @override
  State<CitiesWeatherPage> createState() => _CitiesWeatherPageState();
}

class _CitiesWeatherPageState extends State<CitiesWeatherPage> {
  List<String> cities = ["Jerusalem", "London", "Paris", "Amman", "Granada", "Nablus", "New York", "Algiers"];
  Map<String, bool> favoriteCities = {};

  @override
  void initState() {
    super.initState();
    initializeFavoriteCities();
  }

  Future<void> initializeFavoriteCities() async {
    List<City> allCities = await DatabaseProvider.instance.getAllCities();
    setState(() {
      favoriteCities = Map.fromIterable(
          allCities, key: (city) => city.name, value: (_) => true);
    });
  }


  Future<void> changeFavoriteState( Map<String, dynamic> weatherData) async {
    bool cityExists = await DatabaseProvider.instance.doesCityExist(weatherData["location"]['name']);
    if (cityExists == false) {
      City city = City(id: -1, name: weatherData["location"]['name'],country: weatherData['location']['country']);
      DatabaseProvider.instance.add(city);
      setState(() {
        favoriteCities[weatherData["location"]['name']] = true;
      });
      print("added to favorite");
    } else {
      DatabaseProvider.instance.delete(weatherData["location"]['name']);
      setState(() {
        favoriteCities.remove(weatherData["location"]['name']);
      });
    }
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
      appBar: CustomAppBar(context, "Cities Weather"),
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
                      IconButton(
                          onPressed: (){
                              changeFavoriteState(weatherData);
                              print("star clicked");
                          },
                        icon: Icon(
                          favoriteCities.containsKey(weatherData["location"]['name'])
                              ? Icons.star
                              : Icons.star_border,
                        ),),],
                  ),
                  trailing:
                      ElevatedButton(
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
