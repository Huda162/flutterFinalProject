import 'package:flutter/material.dart';

Widget _buildCard(Map<String, dynamic> forecast) {
  return Card(
    child: Container(
      width:  414, // Set to half of the screen width
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.cloud), // Replace with the actual icon
          Text('Day: ${forecast['date'].toString().substring(0, 10)}'),
          Text('High: ${forecast['maxTemperature']}°C'),
          Text('Low: ${forecast['minTemperature']}°C'),
        ],
      ),
    ),
  );
}