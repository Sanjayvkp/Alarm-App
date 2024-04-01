import 'package:alarm_app/model/alarm_entity.dart';
import 'package:alarm_app/model/alarm_model.dart';
import 'package:alarm_app/objectbox/object_box.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'alarm_provider.g.dart';

@riverpod
class Alarm extends _$Alarm {
  final box = ObjectBox.instance.alarmBox;

  @override
  List<AlarmEntity> build() {
    return [];
  }

  Future<void> addAlarm(AlarmModel alarm) async {
    final alarmEntity = AlarmEntity(time: alarm.time, title: alarm.title);
    box.put(alarmEntity);
  }

  Stream<List<AlarmModel>> getAlarm() async* {
    final alarms = box.getAll();
    final data = [
      for (var alarm in alarms) AlarmModel(time: alarm.time, title: alarm.title)
    ];
    yield data;
  }

  Future<void> removeAll() async {
    box.removeAll();
  }
}
