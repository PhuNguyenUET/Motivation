import 'package:flutter/material.dart';

class TimeUtility {
  static TimeOfDay parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  static TimeOfDay addMinutesToTime(TimeOfDay originalTime, int minutesToAdd) {
    int totalMinutes = originalTime.hour * 60 + originalTime.minute + minutesToAdd;

    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;

    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  static TimeOfDay subtractMinutesFromTime(TimeOfDay originalTime, int minutesToSubtract) {
    int totalMinutes = originalTime.hour * 60 + originalTime.minute - minutesToSubtract;

    int newHour = totalMinutes ~/ 60;
    int newMinute = totalMinutes % 60;

    return TimeOfDay(hour: newHour, minute: newMinute);
  }

  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    String hour = timeOfDay.hour.toString().padLeft(2, '0');
    String minute = timeOfDay.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }
}