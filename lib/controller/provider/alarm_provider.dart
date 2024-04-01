import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alarm_app/model/alarm_model.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final alarmProvider = ChangeNotifierProvider((ref) => AlarmProvider());

class AlarmProvider extends ChangeNotifier {
  final List<Alarm> _alarms = [];

  List<Alarm> get alarms => _alarms;

  void addAlarm(Alarm alarm) {
    _alarms.add(alarm);

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
}
