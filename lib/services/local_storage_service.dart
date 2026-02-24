import 'package:hive/hive.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/data/models/water_model.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';
import 'package:flutter/material.dart';

class LocalStorageService extends ChangeNotifier {
  final Box<DailyStepModel> dailyStepBox;
  final Box<WaterModel> waterBox;
  final Box<ActivityModel> activityBox;

  LocalStorageService({
    required this.dailyStepBox,
    required this.waterBox,
    required this.activityBox,
  });

  Future<void> clearAllData() async {
    await dailyStepBox.clear();
    await waterBox.clear();
    await activityBox.clear();
    notifyListeners();
  }
}
