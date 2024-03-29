import 'package:alarm_app/view/widgets/switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AlarmWidget extends HookWidget {
  const AlarmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var onChanged = useState<bool>(false);
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
      itemCount: 3,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return SizedBox(
          height: 80,
          child: ListTile(
            title: Text(
              '6.30 AM',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(.90)),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text('Mon',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white.withOpacity(.70))),
            ),
            trailing: SwitchWidget(
              value: onChanged.value,
              onChanged: (newValue) {
                onChanged.value = newValue;
              },
            ),
          ),
        );
      },
    );
  }
}
