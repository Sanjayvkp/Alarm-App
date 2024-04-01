import 'package:alarm_app/model/alarm_entity.dart';
import 'package:alarm_app/model/alarm_model.dart';
import 'package:alarm_app/objectbox/object_box.dart';
import 'package:alarm_app/view/pages/add_alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:timezone/timezone.dart' as tz;

part 'alarm_provider.g.dart';

@riverpod
class Alarm extends _$Alarm {
  final box = ObjectBox.instance.alarmBox;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  Alarm() {
    initializeFlutterLocalNotificationsPlugin();
  }

  void initializeFlutterLocalNotificationsPlugin() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  @override
  List<AlarmModel> build() {
    return [];
  }

  final titleController = TextEditingController();

  void addAlarm(AlarmModel alarm) async {
    final alarmEntity = AlarmEntity(
      time: alarm.time.toString(),
      title: alarm.title,
    );
    await scheduleAlarm();
    box.put(alarmEntity);

    getAlarm();
  }

  void getAlarm() {
    final alarms = box.getAll();
    final data = [
      for (var alarm in alarms)
        AlarmModel(id: alarm.id, time: alarm.time, title: alarm.title)
    ];
    state = data;
  }

  void deleteAlarm(int id) {
    box.remove(id);
    getAlarm();
  }

  Future<void> scheduleAlarm() async {
    final now = DateTime.now();
    final selectedTime = ref.watch(selectedTimeProvider);
    final scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
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
      5,
      'Alarm',
      ref.read(alarmProvider.notifier).titleController.text,
      scheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
