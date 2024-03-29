import 'package:alarm_app/model/alarm_model.dart';
import 'package:alarm_app/view/pages/add_alarm_page.dart';
import 'package:alarm_app/view/widgets/alarm_list_widget.dart';
import 'package:alarm_app/view/widgets/clock_widget.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  AlarmPageState createState() => AlarmPageState();
}

class AlarmPageState extends State<AlarmPage> {
  List<Alarm> alarms = []; // List of alarms

  @override
  Widget build(BuildContext context) {
    TimeOfDay time = TimeOfDay.now();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 120,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'ALARM',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            Text(
              '6 Active alarms',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white.withOpacity(.60)),
            ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                size: 30,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            children: [
              const ClockWidget(),
              const SizedBox(
                height: 32,
              ),
              Text(
                time.format(context),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 32,
              ),
              const AlarmWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return const AddAlarmPage();
            },
          ));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
