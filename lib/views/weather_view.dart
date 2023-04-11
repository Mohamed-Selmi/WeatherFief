import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  late String _cityName;
  late String _weatherDescription;
  late double _temperature;
  late String _iconCode;

  @override
  void initState() {
    super.initState();
    _getWeatherData('Sousse');
  }

  Future<void> _getWeatherData(String cityName) async {
    final apiKey = '565231f4c43412eedb1dc65c33def60b';
    final apiUrl = 'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      setState(() {
        _cityName = data['name'];
        _weatherDescription = data['weather'][0]['description'];
        _temperature = data['main']['temp'];
        _iconCode = 'http://openweathermap.org/img/w/${data['weather'][0]['icon']}.png';
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  void _updateWeatherData(String cityName) {
    _getWeatherData(cityName);
  }

  Widget _buildCityInput() {
    return Container(
      margin: EdgeInsets.only(top: 150),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Enter city name',
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search),
        ),
        onSubmitted: (value) => _updateWeatherData(value),
      ),
    );
  }

  Widget _buildWeatherUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: _iconCode == ''
              ? CircularProgressIndicator()
              : Image.network(_iconCode),
        ),
        SizedBox(height: 16),
        Text(
          _cityName,
          style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'OldLondon'),
        ),
        SizedBox(height: 16),
        Text(
          _weatherDescription,
          style: TextStyle(fontSize: 24, color: Colors.white, fontFamily: 'OldLondon'),
        ),
        SizedBox(height: 16),
        Text(
          '${_temperature.toStringAsFixed(1)}°C',
          style: TextStyle(fontSize: 32, color: Colors.white, fontFamily: 'OldLondon'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191720),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCityInput(),
            Expanded(
              child: _buildWeatherUI(),
            ),
          ],
        ),
      ),
    );
  }
}
