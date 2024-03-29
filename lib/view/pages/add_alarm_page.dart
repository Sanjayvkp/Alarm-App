import 'package:alarm_app/view/widgets/elevated_button_widget.dart';
import 'package:flutter/material.dart';

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
    }
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
            Text(
              _selectedTime.format(context),
              style: const TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
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
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
