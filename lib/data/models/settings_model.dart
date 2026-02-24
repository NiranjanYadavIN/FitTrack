import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 3)
class SettingsModel extends HiveObject {
  @HiveField(0)
  late bool enableStepTracking;

  @HiveField(1)
  late bool isDarkMode;

  @HiveField(2)
  late int dailyStepGoal;
}
