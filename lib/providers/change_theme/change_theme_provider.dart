import 'package:equatable/equatable.dart';

import 'package:weather_app_provider/constants/constants.dart';
import 'package:weather_app_provider/providers/weather/weather_provider.dart';

part 'change_theme_state.dart';

class ChangeThemeProvider {
  final WeatherProvider weatherProvider;

  ChangeThemeProvider({required this.weatherProvider});
  ChangeThemeState get state {
    if (weatherProvider.state.weatherModel.temp > kWarmOrNOt) {
      return const ChangeThemeState(appTheme: AppTheme.light);
    } else {
      return const ChangeThemeState(appTheme: AppTheme.dark);
    }
  }
}
