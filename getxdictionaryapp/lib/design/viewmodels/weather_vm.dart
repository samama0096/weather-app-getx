import 'package:get/get.dart';

import '../../data/models/weather_model.dart';
import '../../data/services/weather_service.dart';

class WeatherViewModel extends GetxController {
  final WeatherService _repository = WeatherService();

  WeatherViewModel() {
    weather.value =
        Weather(city: '', description: '', temperature: 0, humidity: 0);
  }
  final Rx<Weather?> weather = Rx(null);
  final RxBool isLoading = RxBool(false);
  final RxBool hasError = RxBool(false);

  Future<void> fetchWeather(String city) async {
    try {
      isLoading.value = true;

      final result = await _repository.getWeather(city.trim());
      weather.value = result;
      hasError.value = false;
    } catch (e) {
      print(e);
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
