import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/data/models/water_model.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';

class LocalStorageService extends ChangeNotifier {
  late Box<DailyStepModel> _dailyStepBox;
  late Box<WaterModel> _waterBox;
  late Box<ActivityModel> _activityBox;

  LocalStorageService() {
    _dailyStepBox = Hive.box<DailyStepModel>('daily_steps');
    _waterBox = Hive.box<WaterModel>('water_intake');
    _activityBox = Hive.box<ActivityModel>('activities');
  }

  Box<DailyStepModel> get dailyStepBox => _dailyStepBox;
  Box<WaterModel> get waterBox => _waterBox;
  Box<ActivityModel> get activityBox => _activityBox;

  Future<void> saveDailySteps(DailyStepModel dailySteps) async {
    await _dailyStepBox.put(dailySteps.date.toIso8601String(), dailySteps);
    notifyListeners();
  }

  Future<void> saveWaterIntake(WaterModel waterIntake) async {
    await _waterBox.put(waterIntake.date.toIso8601String(), waterIntake);
    notifyListeners();
  }

  Future<void> saveActivity(ActivityModel activity) async {
    await _activityBox.add(activity);
    notifyListeners();
  }
}
