import '../api/api.repository.dart';
import '../model/current.weather.data.dart';
import '../model/five.days.data.dart';


class WeatherService {
  final String city;

  String baseUrl = 'https://api.openweathermap.org/data/2.5';
  String apiKey = 'appid=2ef891173650113862ce490045ffe435';


  WeatherService({required this.city});

  void getCurrentWeatherData({
    Function()? beforSend,
    Function(CurrentWeatherData currentWeatherData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/weather?q=$city&lang=en&$apiKey';
    ApiRepository(
      url: '$url',
    ).get(
        beforeSend: () => {
              if (beforSend != null)
                {
                  beforSend(),
                },
            },
        onSuccess: (data) => {
              onSuccess!(CurrentWeatherData.fromJson(data)),
            },
        onError: (error) => {
              if (onError != null)
                {
                  print(error),
                  onError(error),
                }
            });
  }

  void getFiveDaysThreeHoursForcastData({
    Function()? beforSend,
    Function(List<FiveDayData> fiveDayData)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    final url = '$baseUrl/forecast?q=$city&lang=en&$apiKey';
    print(url);
    ApiRepository(
      url: '$url',
    ).get(
        beforeSend: () => {},
        onSuccess: (data) {
          print(data);
          onSuccess!((data['list'] as List)
              .map((t) => FiveDayData.fromJson(t))
              .toList());
        },
        onError: (error) {
          print(error);
          onError!(error);
        });
  }


}
