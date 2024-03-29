import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;

  final void Function() onPressed;
  const ElevatedButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
          style: ButtonStyle(
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor: const MaterialStatePropertyAll(Colors.blue),
            shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}
