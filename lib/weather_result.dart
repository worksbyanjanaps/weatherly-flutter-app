import 'package:flutter/material.dart';
import 'package:weatherly/weather.dart';


class WeatherResultScreen extends StatefulWidget {
  final dynamic LocationWeather;

  const WeatherResultScreen({super.key,required this.LocationWeather});

  @override
  State<WeatherResultScreen> createState() => _WeatherResultScreenState();
}

class _WeatherResultScreenState extends State<WeatherResultScreen> {

  WeatherModel  weatherModel = WeatherModel();

  var countryName;
  var temperature;
  var weatherConditions;
  var weatherConditionCode;
  var weatherIcon;
  var weatherMessage;

  @override
  void initState() {
    super.initState();
    updateUI(widget.LocationWeather);
  }

  void updateUI(dynamic weatherData) {
    if (weatherData == null) {
      debugPrint('Weather data is null');
      return;
    }

    final num temp = weatherData['main']['temp'] as num;
    final int conditionCode = weatherData['weather'][0]['id'] as int;

    setState(() {
      countryName = weatherData['sys']['country'] ?? '';
      weatherConditions = weatherData['weather'][0]['main'] ?? '';

      temperature = temp.toInt();
      weatherConditionCode = conditionCode;

      weatherIcon = weatherModel.getWeatherIcon(conditionCode);
      weatherMessage = weatherModel.getMessage(temperature);
    });

    debugPrint('Country: $countryName');
    debugPrint('Weather: $weatherConditions');
    debugPrint('Temperature: $temperature');
    debugPrint('Icon: $weatherIcon');
    debugPrint('Message: $weatherMessage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                    var WeatherData = await weatherModel.getLocationweather();
                    updateUI(WeatherData);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Color(0xFF0B0D1E),
                        borderRadius: BorderRadius.circular(25),
                      ),
                     child: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back,)),
                     // child: Icon(Icons.location_on,color: Colors.grey,),
                    ),
                  ),
                ],
              ),



              Container(
                margin: EdgeInsets.symmetric(horizontal: 25,vertical: 13),
                child: Text(
                  'Today\'s Report',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                      fontFamily: 'Poppins Bold'
                  ),),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/cloudIntro.png',
                        fit: BoxFit.cover,
                        height: 300,
                      ),
                      // child: Text(
                      //   weatherIcon,
                      //   //'🌧️',
                      //   textAlign: TextAlign.center,
                      //   style: TextStyle(
                      //     fontSize: 150.0
                      //   ),
                      // ),
                    ),
                    Text(
                      weatherIcon,
                     // 'It\'s $weatherConditions',
                      textAlign:TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: 25
                      ),),
                    Text(
                      '$temperature°C',
                      textAlign:TextAlign.center,
                      //style: kTempTextStyle
                      style: TextStyle(
                          fontFamily: 'Poppins Bold',
                          fontSize: 45
                      ),)
                  ],
                ),
              ),

              Container(
                height: 95,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xFF0B0D1E),
                ),
                child: Text(
                  "$weatherMessage in $countryName!",
                  textAlign: TextAlign.center,
                  //style: kMessageTextStyle,
                  style: TextStyle(
                      fontFamily: 'Poppins Bold',
                      fontSize: 20
                  ),),
              ),
              Container(
                margin: EdgeInsets.only(top: 8),
                child: FloatingActionButton(onPressed: () {

                },
                  child: Icon(Icons.search,color: Colors.blue,),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
