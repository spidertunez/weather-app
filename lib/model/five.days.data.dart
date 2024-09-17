import 'package:intl/intl.dart';

class FiveDayData {
  final String? date;
  final String? time;
  final int? temp;

  FiveDayData({this.date, this.time, this.temp});

  factory FiveDayData.fromJson(dynamic json) {
    if (json == null) {
      return FiveDayData();
    }

    DateTime dateTime = DateTime.parse(json['dt_txt']);
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return FiveDayData(
      date: formattedDate,
      time: formattedTime,
      temp: (double.parse(json['main']['temp'].toString()) - 273.15).round(),
    );
  }
}
