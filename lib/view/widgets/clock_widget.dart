import 'package:flutter/material.dart';
import 'package:one_clock/one_clock.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 180,
      child: AnalogClock(
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: Colors.grey),
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        width: 150,
        isLive: true,
        hourHandColor: Colors.white,
        minuteHandColor: Colors.white,
        showSecondHand: true,
        secondHandColor: Colors.white,
        numberColor: Colors.white,
        showNumbers: true,
        showAllNumbers: true,
        textScaleFactor: 1.4,
        showTicks: false,
        showDigitalClock: false,
        datetime: DateTime.now(),
      ),
    );
  }
}
