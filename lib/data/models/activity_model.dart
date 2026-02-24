import 'package:hive/hive.dart';

part 'activity_model.g.dart';

@HiveType(typeId: 0)
class ActivityModel extends HiveObject {
  @HiveField(0)
  late String type;

  @HiveField(1)
  late int duration;

  @HiveField(2)
  late double distance;

  @HiveField(3)
  late int calories;

  @HiveField(4)
  late DateTime date;

  ActivityModel({required this.type, required this.duration, required this.distance, required this.calories, required this.date});
}
