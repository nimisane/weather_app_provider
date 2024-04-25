part of 'temp_settings_provider.dart';

class TempSettingsProvider with ChangeNotifier {
  TempSettingState _state = TempSettingState.initial();

  TempSettingState get state => _state;

  void toggleTempUnit() {
    _state = _state.copyWith(
        tempUnit: TempUnit.celsius == state.tempUnit
            ? TempUnit.fahrenheit
            : TempUnit.celsius);

    notifyListeners();
  }
}
