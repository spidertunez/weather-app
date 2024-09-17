import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/utils/binding/HomeBinding.dart';
import 'package:weather_app/view/HomeScreen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( debugShowCheckedModeBanner: false,
      home: Home(),
      initialBinding: HomeBinding(),
    );
  }
}
