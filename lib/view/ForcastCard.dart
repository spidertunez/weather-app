import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/HomeController.dart';
import '../model/five.days.data.dart';
import '../model/weather.dart';

class ForecastCard extends StatelessWidget {
  final FiveDayData data;
  final Weather weather;

  ForecastCard({
    required this.data,
    required this.weather, required String description,
  });

  Map<String, String> getWeatherInfoForTemperature(int temp) {
    if (temp <= 0) {
      return {
        'icon': 'http://openweathermap.org/img/wn/snow@2x.png',
        'description': 'Snowy and cold',
      };
    } else if (temp <= 10) {
      return {
        'icon': 'http://openweathermap.org/img/wn/13d@2x.png',
        'description': 'Chilly and cool',
      };
    } else if (temp <= 20) {
      return {
        'icon': 'http://openweathermap.org/img/wn/10d@2x.png',
        'description': 'Mild and pleasant',
      };
    } else if (temp <= 30) {
      return {
        'icon': 'http://openweathermap.org/img/wn/01d@2x.png',
        'description': 'Warm and sunny',
      };
    } else {
      return {
        'icon': 'http://openweathermap.org/img/wn/02d@2x.png',
        'description': 'Hot and sunny',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        // Fetch the temperature and description
        final temp = data.temp ?? 0;
        final weatherInfo = getWeatherInfoForTemperature(temp);
        final iconUrl = weatherInfo['icon'] ?? '';
        final date = data.date ?? 'No date available';
        final time = data.time ?? 'No time available';
        final description = weatherInfo['description'] ?? '';

        return Card(
          color: Colors.transparent,
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            leading: iconUrl.isNotEmpty
                ? Image.network(
              iconUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.error, size: 50, color: Colors.red);
              },
            )
                : SizedBox(width: 50, height: 50),
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${temp}°C',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        time,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
