import 'package:alarm_app/controller/provider/alarm_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlarmWidget extends HookConsumerWidget {
  const AlarmWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final alarms = ref.watch(alarmProvider);
        return ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 32,
            );
          },
          itemCount: alarms.length,
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final alarms = ref.watch(alarmProvider);
            return SizedBox(
              height: 80,
              child: ListTile(
                  title: Text(
                    alarms[index]
                        .time, // Display the hour and minute of the alarm
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(.90),
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Everyday',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.white.withOpacity(.70),
                      ),
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        ref
                            .read(alarmProvider.notifier)
                            .deleteAlarm(alarms[index].id!);
                      },
                      icon: Icon(
                        Icons.delete,
                        size: 30,
                        color: Colors.white.withOpacity(.50),
                      ))),
            );
          },
        );
      },
    );
  }
}
