import 'package:alarm_app/view/widgets/switch_widget.dart';
import 'package:flutter/material.dart';

class AlarmWidget extends StatelessWidget {
  const AlarmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          height: 16,
        );
      },
      itemCount: 10,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
          child: ListTile(
            title: const Text(
              '6.30 AM',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            subtitle: const Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text('Mon',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300)),
            ),
            trailing: SwitchWidget(onChanged: (p0) {}, value: false),
          ),
        );
      },
    );
  }
}
