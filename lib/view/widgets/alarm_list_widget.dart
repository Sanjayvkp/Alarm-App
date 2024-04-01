import 'package:alarm_app/model/alarm_model.dart';
import 'package:alarm_app/view/widgets/switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlarmWidget extends HookWidget {
  final List<Alarm> alarms;

  const AlarmWidget({
    super.key,
    required this.alarms,
  });

  @override
  Widget build(BuildContext context) {
    var onChanged = useState<bool>(false);
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
      itemCount: alarms.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        final alarm = alarms[index];
        return SizedBox(
          height: 80,
          child: ListTile(
            title: Text(
              alarm.time, // Display the hour and minute of the alarm
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white.withOpacity(.90),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Monday', // Display the day of the alarm
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(.70),
                ),
              ),
            ),
            trailing: SwitchWidget(
              value: onChanged.value, // Use the isActive property of Alarm
              onChanged: (newValue) {
                // Update the isActive property of the alarm
                onChanged.value = newValue;
                // You might want to call a function to update the alarm status in your data provider
              },
            ),
          ),
        );
      },
    );
  }
}
