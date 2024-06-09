import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//فوزي ذوالفقار جبور
const String apiKey = '045e4dc4938c343cf22e03e178be24f9'
;

void main() {
  runApp(MyApp());
}
//محمد نور نعيسة
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WeatherScreen(),
    );
  }
}
//علي صالح علي
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}
// فراس أمير صالحة
class _WeatherScreenState extends State<WeatherScreen> {
  String _cityName = 'London';
  IconData _weatherIcon = Icons.help_outline;
  String _description = '';
  String _cityFetched = '';
  bool _isLoading = true;
//محمد شيخ سليمان
  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    setState(() {
      _isLoading = true;
    });
//فوزي ذوالفقار جبور
    final url = 'https://api.openweathermap.org/data/2.5/weather?q=$_cityName&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));
    print('API Response: ${response.body}'); // Debug statement

    if (response.statusCode == 200) {
      final weatherData = json.decode(response.body);
      print('Weather Data: $weatherData'); // Debug statement
//علي هاني ابراهيم
      setState(() {
        _description = weatherData['weather'][0]['description'];
        _cityFetched = weatherData['name'];
        _weatherIcon = getWeatherIcon(weatherData['weather'][0]['main']);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }
  //علي ضرار ابراهيم
  IconData getWeatherIcon(String weatherDescription) {
    switch (weatherDescription.toLowerCase()) {
      case 'clear':
        return Icons.wb_sunny;
      case 'clouds':
        return Icons.cloud;
      case 'rain':
        return Icons.umbrella;
      case 'snow':
        return Icons.ac_unit;
      case 'thunderstorm':
        return Icons.flash_on;
      case 'drizzle':
        return Icons.grain;
//ليث معمر أسبر
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
      case 'sand':
      case 'ash':
      case 'squall':
      case 'tornado':
        return Icons.blur_on;
      default:
        return Icons.help_outline;
    }
  }
//فياض يحيى قفورة
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(70, 0,120,0.2),
        shadowColor: Colors.black54,
        elevation: 10,
      ),
      //أسامة خير بك
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _cityFetched,
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),//علي نادر علي
              SizedBox(height: 20),
              Icon(
                _weatherIcon,
                size: 100,
                color: Colors.orange,
              ),
              //ابراهيم عصام ابراهيم
              SizedBox(height: 20),
              Text(
                _description,
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  fetchWeather();
                },
                child: Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}