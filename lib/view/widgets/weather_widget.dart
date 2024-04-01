import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final String weather;
  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 60,
        width: 120,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 2, color: Colors.white.withOpacity(.50)),
            ],
            border: Border.all(color: Colors.grey.withOpacity(.20)),
            color: Colors.black,
            borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            '🌦️$weather ℃', // Display current weather
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
}
