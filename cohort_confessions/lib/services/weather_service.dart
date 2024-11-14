import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String apiKey =
      '11a5b159429d4f208290daa61e170ccc'; // Your API key
  static const String apiUrl =
      'https://api.openweathermap.org/data/2.5/weather';

  Future<double?> getTemperature(double latitude, double longitude) async {
    final url = Uri.parse(
        '$apiUrl?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['main']['temp']; // Return temperature in Celsius
      } else {
        print('Failed to fetch weather data');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
