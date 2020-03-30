import 'package:covid_19_app/screens/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "COVID 19 Cases",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          brightness: Brightness.dark
        )
      ),
      home: Home(),
    );
  }
}