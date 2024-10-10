import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:location/location.dart';
import 'package:xteamtask/networking_api/weather_info_class.dart';

class OpenWeatherMapDio {
  final dio = Dio(BaseOptions(receiveTimeout: Duration(seconds: 30), maxRedirects: 4, connectTimeout: Duration(seconds: 30)));

  Future<WeatherInfoClass?> GetWeatherData(LocationData _currentPosition) async {
    try {
      final answer = await dio.get("https://api.openweathermap.org/data/2.5/weather?lat=${_currentPosition.latitude}&lon=${_currentPosition.longitude}&appid=${dotenv.env['OPENWEATHER_API_KEY']}").whenComplete(() {});
      Map<String, dynamic> answerMap = jsonDecode(jsonEncode(answer.data));
      //Fields of api answer
      final weather = answerMap['weather'];
      final wind = answerMap['wind'];
      final coordinatesLat = answerMap['coord'];
      final coordinatesLon = answerMap['coord'];
      final timezone = answerMap['name'];
      final humidity = answerMap['main'];
      WeatherInfoClass response = WeatherInfoClass(timezone: timezone, lat: coordinatesLat['lat'], lon: coordinatesLon['lon'], description: weather[0]['description'], WindSpeed: wind['speed'], Weather: weather[0]['main'], WeatherCode: weather[0]['id'], humidity: humidity['humidity']);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
