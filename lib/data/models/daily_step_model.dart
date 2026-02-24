import 'package:hive/hive.dart';

part 'daily_step_model.g.dart';

@HiveType(typeId: 1)
class DailyStepModel extends HiveObject {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  late int steps;

  DailyStepModel({required this.date, required this.steps});
}
