import 'package:flutter/material.dart';

class TimeWidget extends StatelessWidget {
  final String time;
  const TimeWidget({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.grey, width: 4),
          boxShadow: [
            BoxShadow(blurRadius: 3, color: Colors.white.withOpacity(.50))
          ],
          borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: Text(
          time,
          style: const TextStyle(
            fontSize: 35,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
