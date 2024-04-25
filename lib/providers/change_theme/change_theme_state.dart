part of 'change_theme_provider.dart';

class ChangeThemeProvider with ChangeNotifier {
  ChangeThemeState _state = ChangeThemeState.initial();

  ChangeThemeState get state => _state;

  void update(WeatherProvider weatherProvider) {
    if (weatherProvider.state.weatherModel.temp > kWarmOrNOt) {
      _state = _state.copyWith(appTheme: AppTheme.light);
    } else {
      _state = _state.copyWith(appTheme: AppTheme.dark);
    }

    notifyListeners();
  }

  // final WeatherProvider weatherProvider;

  // ChangeThemeProvider({required this.weatherProvider});
}
