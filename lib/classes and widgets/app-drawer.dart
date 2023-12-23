import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes%20and%20widgets/cities_page.dart';
import 'package:flutter_final_project/classes%20and%20widgets/daily_weather_page.dart';
import 'package:flutter_final_project/classes%20and%20widgets/home_page.dart';
import 'package:flutter_final_project/classes%20and%20widgets/hourly-weather-page.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Menu'),
          ),
          ListTile(
            title: Text('Home'),
            selected:  _selectedIndex == 0,
            onTap: () {
              _onItemTapped(0);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            title: Text('Cities Weather'),
            selected:  _selectedIndex == 1,
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CitiesWeatherPage()),
              );
            },
          ),
          ListTile(
            title: Text('Daily Weather'),
            selected:  _selectedIndex == 2,
            onTap: () {
              _onItemTapped(1);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DailyWeatherPage()),
              );
            },
          ),
          ListTile(
            title: Text('Hourly Weather'),
            selected:  _selectedIndex == 3,
            onTap: () {
              _onItemTapped(3);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HourlyWeatherPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
