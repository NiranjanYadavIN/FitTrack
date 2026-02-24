import 'package:hive/hive.dart';

part 'daily_step_model.g.dart';

@HiveType(typeId: 0)
class DailyStepModel extends HiveObject {
  @HiveField(0)
  final DateTime date;

  @HiveField(1)
  final int steps;

  DailyStepModel({required this.date, required this.steps});
}
