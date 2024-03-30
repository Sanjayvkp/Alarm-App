// ignore_for_file: use_build_context_synchronously

import 'package:alarm_app/view/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class AddAlarmPage extends StatefulWidget {
  const AddAlarmPage({super.key});

  @override
  AddAlarmPageState createState() => AddAlarmPageState();
}

class AddAlarmPageState extends State<AddAlarmPage> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      _scheduleAlarm(context);
    }
  }

  Future<void> _scheduleAlarm(BuildContext context) async {
    final DateTime now = DateTime.now();
    final tz.TZDateTime scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _selectedTime.hour,
      _selectedTime.minute,
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
      'Time to wake up!',
      scheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        toolbarHeight: 60,
        title: const Text(
          'SET ALARM',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => _selectTime(context),
              child: Text(
                _selectedTime.format(context),
                style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButtonWidget(
                text: 'SET',
                onPressed: () => _selectTime(context),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: ElevatedButtonWidget(
                text: 'SAVE',
                onPressed: () {
                  _scheduleAlarm(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
