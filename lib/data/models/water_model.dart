import 'package:hive/hive.dart';

part 'water_model.g.dart';

@HiveType(typeId: 2)
class WaterModel extends HiveObject {
  @HiveField(0)
  late DateTime date;

  @HiveField(1)
  late int amount;

  WaterModel({required this.date, required this.amount});
}
