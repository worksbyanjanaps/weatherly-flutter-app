import 'location.dart';
import 'networking.dart';

const apiKey = 'c67a8ad51a3e28fa1fae4f1c1894127a';

class WeatherModel {
  Future<dynamic> getLocationweather() async {
    // Get the current location
    final Location location = await Location.getCurrentLocation();

    final double? latitude = location.latitude;
    final double? longitude = location.longitude;

    if (latitude == null || longitude == null) {
      throw Exception('Unable to get current location');
    }

    // Create the weather API URL
    final NetworkBrain networkBrain = NetworkBrain(
      'https://api.openweathermap.org/data/2.5/weather'
          '?lat=$latitude&lon=$longitude&units=metric&appid=$apiKey',
    );

    // Return the weather data
    final weatherData = await networkBrain.getData();

    return weatherData;
  }

  String getWeatherIcon(int weatherConditionCode) {
    if (weatherConditionCode < 300) {
      return '☁️';
    } else if (weatherConditionCode < 400) {
      return '🌧️';
    } else if (weatherConditionCode < 600) {
      return '☔';
    } else if (weatherConditionCode < 700) {
      return '⛈️';
    } else if (weatherConditionCode < 800) {
      return '🌧️';
    } else if (weatherConditionCode == 800) {
      return '☀️';
    } else if (weatherConditionCode <= 804) {
      return '☁️';
    } else {
      return '🤷';
    }
  }

  String getMessage(int temperature) {
    if (temperature > 25) {
      return "It's 🍦 time";
    } else if (temperature > 20) {
      return 'Time for 🩳 and 👕';
    } else if (temperature < 10) {
      return "You'll need 🧤 and 🧦";
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
