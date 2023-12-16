
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

  Future<void> changeFavoriteState( Map<String, dynamic> weatherData) async {
    bool cityExists = await DatabaseProvider.instance.doesCityExist(weatherData["location"]['name']);
    if (cityExists == false) {
      City city = City(id: -1, name: weatherData["location"]['name'],country: weatherData['location']['country']);
      DatabaseProvider.instance.add(city);
    } else {
      DatabaseProvider.instance.delete(weatherData["location"]['name']);
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
                  subtitle: Row(
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
                          },
                        icon: Icon(
                            DatabaseProvider.instance.doesCityExist(weatherData["location"]['name'])==true
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
