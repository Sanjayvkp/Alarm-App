import 'package:alarm_app/controller/provider/alarm_provider.dart';
import 'package:alarm_app/controller/services/api_services.dart';
import 'package:alarm_app/model/alarm_model.dart';
import 'package:alarm_app/view/widgets/elevated_button_widget.dart';
import 'package:alarm_app/view/widgets/time_widget.dart';
import 'package:alarm_app/view/widgets/weather_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final selectedTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());

class AddAlarmPage extends ConsumerWidget {
  const AddAlarmPage({super.key});

  Future<void> selectTime(BuildContext context, WidgetRef ref) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: ref.watch(selectedTimeProvider),
    );
    if (pickedTime != null) {
      ref.read(selectedTimeProvider.notifier).state =
          pickedTime; // Update selected time
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apiServices = ApiServices(); // Create an instance of ApiServices

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        toolbarHeight: 90,
        title: const Text(
          'SET ALARM',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FutureBuilder<String>(
            future:
                apiServices.getCurrentWeather(), // Fetch current weather data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final currentWeather =
                    snapshot.data; // Get the current weather data
                return WeatherWidget(weather: currentWeather!);
              }
            },
          ),
          const SizedBox(height: 120),
          Center(
              child: InkWell(
            onTap: () => selectTime(context, ref),
            child: TimeWidget(
              time:
                  ref.read(selectedTimeProvider.notifier).state.format(context),
            ),
          )),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ElevatedButtonWidget(
          text: 'SET',
          onPressed: () {
            ref.read(alarmProvider.notifier).addAlarm(AlarmModel(
                  time: formatTimeOfDay(
                      ref.read(selectedTimeProvider.notifier).state),
                  title: 'Alarm',
                ));
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
