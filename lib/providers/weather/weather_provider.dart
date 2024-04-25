// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_state_notifier/flutter_state_notifier.dart';

import 'package:weather_app_provider/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather_model.dart';

part 'weather_state.dart';

class WeatherProvider extends StateNotifier<WeatherState> with LocatorMixin {
  WeatherProvider() : super(WeatherState.initial());

  Future<void> fetchWeather(String city) async {
    try {
      state = state.copyWith(status: WeatherStatus.loading);

      final WeatherModel weatherModel = await read<WeatherRepository>()
          .fetchWeather(city);

      state = state.copyWith(
          weatherModel: weatherModel, status: WeatherStatus.loaded);
    } on CustomError catch (e) {
      state = state.copyWith(status: WeatherStatus.error, customError: e);
    }
  }
}
