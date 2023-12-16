import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';
import 'app-drawer.dart';
import 'package:provider/provider.dart';
import 'city-prrovider.dart';

class DailyWeatherPage extends StatelessWidget {
  const DailyWeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String selectedCity = Provider.of<CityProvider>(context).selectedCity;

    return Scaffold(
      appBar: CustomAppBar("Daily Weather in ${selectedCity}"),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchWeatherData().getDailyWeatherData(selectedCity),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Map<String, dynamic>> data = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: (data.length / 2).ceil(),
              itemBuilder: (context, rowIndex) {
                int startIndex = rowIndex * 2;
                return Row(
                  children: [
                    if (startIndex < data.length) _buildCard(context, data[startIndex]),
                    if (startIndex + 1 < data.length) _buildCard(context, data[startIndex + 1]),
                  ],
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, Map<String, dynamic> forecast) {
    return SizedBox(
      height: 200.0,
      child: Card(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5 - 10,
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.network(
                    forecast['condition']['icon'],
                    width: 110,
                    height: 110,
                  ),
                ),
                Text('${forecast['date'].toString().substring(0, 10)}'),
                Text('High: ${forecast['maxTemperature']}°C'),
                Text('Low: ${forecast['minTemperature']}°C'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
