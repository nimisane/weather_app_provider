// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:weather_app_provider/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather_model.dart';

part 'weather_state.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherRepository repository;
  WeatherProvider({
    required this.repository,
  });
  WeatherState _state = WeatherState.initial();

  WeatherState get state => _state;

  Future<void> fetchWeather(String city) async {
    try {
      _state = _state.copyWith(status: WeatherStatus.loading);
      notifyListeners();
      final WeatherModel weatherModel = await repository.fetchWeather(city);

      _state = _state.copyWith(
          weatherModel: weatherModel, status: WeatherStatus.loaded);
     
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(status: WeatherStatus.error, customError: e);
     
      notifyListeners();
    }
  }
}
