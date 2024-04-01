import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:alarm_app/model/alarm_model.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final alarmProvider = ChangeNotifierProvider((ref) => AlarmProvider());

class AlarmProvider extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);
    scheduleAlarm(alarm);
    notifyListeners();
  }

  void removeAlarm(Alarm alarm) {
    _alarms.remove(alarm);
    notifyListeners();
  }

  void updateAlarm(Alarm oldAlarm, Alarm newAlarm) {
    final index = _alarms.indexOf(oldAlarm);
    if (index != -1) {
      _alarms[index] = newAlarm;
      notifyListeners();
    }
  }

  Future<void> scheduleAlarm(Alarm alarm) async {
    final scheduledTime = _getNextAlarmDateTime(alarm.time);
    if (scheduledTime != null) {
      const AndroidNotificationDetails androidPlatformChannelSpecifics =
          AndroidNotificationDetails(
        'alarm_channel',
        'Alarm Notification',
        importance: Importance.high,
        priority: Priority.high,
        playSound: true,
        sound: RawResourceAndroidNotificationSound('notification_sound'),
      );
      const NotificationDetails platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.zonedSchedule(
        alarm.id,
        'Alarm',
        'Time to wake up!',
        scheduledTime,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  tz.TZDateTime? _getNextAlarmDateTime(String time) {
    try {
      // Split the time string into hours and minutes
      final parts = time.split(":");

      if (parts.length != 2) {
        // Invalid time format, return null
        return null;
      }

      final int hours = int.parse(parts[0]);
      final int minutes = int.parse(parts[1]);

      // Check if hours and minutes are within valid ranges
      if (hours < 0 || hours > 23 || minutes < 0 || minutes > 59) {
        // Invalid time range, return null
        return null;
      }

      // Get current time in local timezone
      final now = tz.TZDateTime.now(tz.local);

      // Create a TZDateTime object for the alarm time
      final alarmTime = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hours,
        minutes,
      );

      // Return the alarm time
      return alarmTime;
    } catch (e) {
      // Error parsing time string, return null
      return null;
    }
  }
}
