import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/fetch_api_data.dart';
import 'CustomAppBar.dart';
import 'app-drawer.dart';

class DailyWeatherPage extends StatefulWidget {
  const DailyWeatherPage({Key? key}) : super(key: key);

  @override
  State<DailyWeatherPage> createState() => _DailyWeatherPageState();
}

class _DailyWeatherPageState extends State<DailyWeatherPage> {
  late Future<List<Map<String, dynamic>>> futureDailyWeatherData;
  fetchWeatherData DailyWeatherData = fetchWeatherData();

  @override
  void initState() {
    super.initState();
    futureDailyWeatherData = DailyWeatherData.getDailyWeatherData("London");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Daily Weather"),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureDailyWeatherData,
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
                    if (startIndex < data.length) _buildCard(data[startIndex]),
                    if (startIndex + 1 < data.length) _buildCard(data[startIndex + 1]),
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

  Widget _buildCard(Map<String, dynamic> forecast) {
    return SizedBox(
      height: 200.0,
      child: Card(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 0.5-10,
          padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    forecast['condition']['icon'],
                    width: 110,
                    height: 110,
                  ),
                  Text('High: ${forecast['maxTemperature']}°C'),
                  Text('Low: ${forecast['minTemperature']}°C'),
                  Text('${forecast['date'].toString().substring(0, 10)}'),
                ],
          ),
          )
        ),
      ),
    );
  }
}