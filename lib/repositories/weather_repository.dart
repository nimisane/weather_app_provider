import '../exceptions/weather_exceptions.dart';
import '../models/custom_error.dart';
import '../models/direct_geocoding.dart';
import '../models/weather_model.dart';
import '../services/weather_api_services.dart';

class WeatherRepository {
  WeatherRepository({required this.weatherApiServices});
  final WeatherApiServices weatherApiServices;

  Future<WeatherModel> fetchWeather(String city) async {
    try {
      final DirectGeocodingModel directGeocodingModel =
          await weatherApiServices.getDirectGeocoding(city);

      final WeatherModel tempWeather =
          await weatherApiServices.getWeather(directGeocodingModel);

      final WeatherModel weatherModel = tempWeather.copyWith(
          name: directGeocodingModel.name,
          country: directGeocodingModel.country);

      return weatherModel;
    } on WeatherExceptions catch (e) {
      throw CustomError(errorMsg: e.message);
    } catch (e) {
      throw CustomError(errorMsg: e.toString());
    }
  }
}