import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherly/weather.dart';
import 'package:weatherly/weather_result.dart';

const apiKey = 'c67a8ad51a3e28fa1fae4f1c1894127a';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<void> getLocationData() async {
    try {
      WeatherModel weatherModel = WeatherModel();
      var WeatherData = await weatherModel.getLocationweather();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WeatherResultScreen(
              LocationWeather:  WeatherData,
            );
          },
        ),
      );
    } catch (e) {
      print('Error getting weather: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Unable to get weather. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Image.asset('assets/images/cloudIntro.png', height: 350.0,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(12),
            child: Text(
              'Discover the Weather in Your City',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0,
                fontFamily: 'Poppins Bold',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.all(16),
            child: Text(
              'Get to Know your weather maps and radar precipitation forecast',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.0,
                  fontFamily: 'Poppins Regular',
                  color: Colors.grey.shade400
              ),
            ),
          ),

          const SizedBox(height: 16),

          GestureDetector(
            onTap: () {
              getLocationData();
            },
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(20),
              height: 58.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade600,
                borderRadius: BorderRadius.circular(16),),
              child: Text(
                'Get Weather',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Poppins Regular',
                  fontSize: 15.0,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

