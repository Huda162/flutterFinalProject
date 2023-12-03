import 'package:flutter/material.dart';
import 'app-drawer.dart';


PreferredSizeWidget? CustomAppBar(String title) {
  return AppBar(
      backgroundColor: Colors.indigo,

      iconTheme: const IconThemeData(size: 40, color: Colors.white),
      title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 250, 250, 250)),
          ),
          ),
      );
}
