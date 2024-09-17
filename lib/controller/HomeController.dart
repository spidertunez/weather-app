import 'package:get/get.dart';
import '../model/current.weather.data.dart';
import '../model/five.days.data.dart';
import '../model/weather.dart';
import '../service/weatherservice.dart';

class HomeController extends GetxController {
  String? city;
  String? searchText;

  CurrentWeatherData currentWeatherData = CurrentWeatherData();
  List<CurrentWeatherData> dataList = [];
  List<FiveDayData> fiveDaysData = [];
  Map<String, Weather> weatherMap = {};
  Weather weather = Weather();

  HomeController({required this.city});

  @override
  void onInit() {
    super.onInit();
    initState();
    getTopFiveCities();
  }

  void updateWeather() {
    initState();
  }

  void initState() {
    getCurrentWeatherData();
    getFiveDaysData();
  }

  void getCurrentWeatherData() {
    WeatherService(city: city ?? '').getCurrentWeatherData(
      onSuccess: (data) {
        currentWeatherData = data;
        update();
      },
      onError: (error) {
        print('Error fetching current weather data: $error');
        update();
      },
    );
  }

  void getTopFiveCities() {
    List<String> cities = [
      'zagazig',
      'cairo',
      'alexandria',
      'ismailia',
      'fayoum'
    ];
    cities.forEach((c) {
      WeatherService(city: c).getCurrentWeatherData(
        onSuccess: (data) {
          dataList.add(data);
          update();
        },
        onError: (error) {
          print('Error fetching weather data for $c: $error');
          update();
        },
      );
    });
  }

  void getFiveDaysData() {
    WeatherService(city: city ?? '').getFiveDaysThreeHoursForcastData(
      onSuccess: (data) {
        fiveDaysData = data;
        weatherMap.clear();
        for (var dayData in data) {
          final key = '${dayData.date} ${dayData.time}';
          WeatherService(city: city ?? '').getCurrentWeatherData(
            onSuccess: (weatherData) {
              if (weatherData.weather != null && weatherData.weather!.isNotEmpty) {
                weatherMap[key] = Weather(
                  id: weatherData.weather![0].id,
                  main: weatherData.weather![0].main,
                  description: weatherData.weather![0].description,
                  icon: weatherData.weather![0].icon,
                );
              } else {
                weatherMap[key] = Weather();
              }
              update();
            },
            onError: (error) {
              print('Error fetching weather data for $key: $error');
            },
          );
        }
      },
      onError: (error) {
        print('Error fetching five days forecast data: $error');
        update();
      },
    );
  }

}
