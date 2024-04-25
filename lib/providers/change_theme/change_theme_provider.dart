import 'package:equatable/equatable.dart';

import 'package:state_notifier/state_notifier.dart';

import 'package:weather_app_provider/constants/constants.dart';
import 'package:weather_app_provider/providers/weather/weather_provider.dart';

part 'change_theme_state.dart';

class ChangeThemeProvider extends StateNotifier<ChangeThemeState>
    with LocatorMixin {
  ChangeThemeProvider() : super(ChangeThemeState.initial());

  @override
  void update(Locator watch) {

    WeatherState weatherState = watch<WeatherState>();
    if (weatherState.weatherModel.temp > kWarmOrNOt) {
      state = state.copyWith(appTheme: AppTheme.light);
    } else {
      state = state.copyWith(appTheme: AppTheme.dark);
    }
    super.update(watch);
  }
}
