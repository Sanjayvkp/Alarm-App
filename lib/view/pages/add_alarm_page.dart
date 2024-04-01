import 'package:alarm_app/controller/services/api_services.dart';
import 'package:alarm_app/view/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedTimeProvider = StateProvider<TimeOfDay>((ref) => TimeOfDay.now());

class AddAlarmPage extends ConsumerWidget {
  const AddAlarmPage({super.key});

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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    height: 60,
                    width: 120,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 2,
                              color: Colors.white.withOpacity(.50)),
                        ],
                        border: Border.all(color: Colors.grey.withOpacity(.20)),
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        '🌦️$currentWeather ℃', // Display current weather
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 32),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.grey, width: 4),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3, color: Colors.white.withOpacity(.50))
                    ],
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Text(
                    ref
                        .read(selectedTimeProvider.notifier)
                        .state
                        .format(context),
                    style: const TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ElevatedButtonWidget(
          text: 'SET',
          onPressed: () {},
        ),
      ),
    );
  }
}
