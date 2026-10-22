import 'package:flutter/material.dart';
import 'package:weatherly/loading_screen.dart';

void main() {
  runApp(Weatherly());
}
class Weatherly extends StatefulWidget {
  const Weatherly({super.key});

  @override
  State<Weatherly> createState() => _WeatherlyState();
}

class _WeatherlyState extends State<Weatherly> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoadingScreen(),
    );
  }
}
