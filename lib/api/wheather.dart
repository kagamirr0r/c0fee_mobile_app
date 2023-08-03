import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/weather.dart';

Future<Weather> fetchWeather() async {
  const place = 'Kyoto';

  var url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/weather?q=Tokyo&appid=9aa60795275773b32c66719a8224fdf4&lang=ja');

  var res = await http.get(url);

  if (res.statusCode == 200) {
    var body = res.body;
    var json = jsonDecode(body);
    var model = Weather.fromJson(json);

    return model;
  } else {
    throw Exception('Failed to load weather');
  }
}
