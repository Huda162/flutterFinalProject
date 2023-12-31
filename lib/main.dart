import 'package:flutter/material.dart';
import 'package:flutter_final_project/classes and widgets/home_page.dart';
import 'package:flutter_final_project/classes%20and%20widgets/city-prrovider.dart';
import 'package:provider/provider.dart';
import 'classes and widgets/city-database.dart';


void main() async{

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>CityProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );

  }
}













