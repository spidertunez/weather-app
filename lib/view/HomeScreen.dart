import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../constant/images.dart';
import '../controller/HomeController.dart';
import '../model/weather.dart';
import 'ForcastCard.dart';
import 'package:flutter/scheduler.dart';

class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HomeController>(
        builder: (controller) {
          final weatherData = controller.currentWeatherData;
          final fiveDaysData = controller.fiveDaysData;
          final weatherMap = controller.weatherMap;

          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue.shade900, Colors.cyan.shade50],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                    child: TextField(
                      onChanged: (value) {
                        SchedulerBinding.instance.addPostFrameCallback((_) {
                          controller.city = value;
                          controller.updateWeather();
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search, color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: 'Search'.toUpperCase(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            '${weatherData.name ?? 'Unknown City'}'.toUpperCase(),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black54,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'flutterfonts',
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            DateFormat('MMMM d, yyyy').format(DateTime.now()),
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 90,
                    height: 90,
                    child: weatherData.main != null
                        ? LottieBuilder.asset(
                      Images.cloudyMain,
                    )
                        : SizedBox.shrink(),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '${((weatherData.main?.temp ?? 0) - 273.15).round()}°C',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: Colors.black54,
                      fontFamily: 'flutterfonts',
                    ),
                  ),
                  Text(
                    'L: ${((weatherData.main?.tempMin ?? 0) - 273.15).round()}°C / H: ${((weatherData.main?.tempMax ?? 0) - 273.15).round()}°C',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'flutterfonts',
                    ),
                  ),
                  SizedBox(height: 18),
                  Text(
                    'The forecast for the next 3 hours and 5 days',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: fiveDaysData.length,
                      itemBuilder: (context, index) {
                        final dayData = fiveDaysData[index];
                        final key = '${dayData.date} ${dayData.time}';
                        final description = weatherMap[key]?.description ?? 'No description available';

                        return ForecastCard(
                          data: dayData,
                          weather: Weather(description: description),
                          description: description,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

