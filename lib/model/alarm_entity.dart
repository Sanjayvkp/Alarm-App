import 'package:objectbox/objectbox.dart';

@Entity()
class AlarmEntity {
  @Id()
  int id = 0;

  final String time;
  final String title;

  AlarmEntity({required this.time, required this.title});
}
