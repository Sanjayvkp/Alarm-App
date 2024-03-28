import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final void Function(bool)? onChanged;
  final bool value;
  const SwitchWidget({super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .70,
      child: Switch(
        thumbIcon: MaterialStateProperty.all(const Icon(
          Icons.circle,
          color: Colors.white,
        )),
        trackOutlineColor:
            const MaterialStatePropertyAll(Colors.grey),
        activeColor: Colors.red,
        thumbColor: MaterialStateProperty.all(Colors.white),
        activeTrackColor: Colors.black,
        inactiveTrackColor: Colors.grey,
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}