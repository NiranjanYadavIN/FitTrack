
import 'package:hive/hive.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/data/models/water_model.dart';
import 'dart:io';

Future<void> setupTestHive() async {
  final path = Directory.current.path;
  Hive.init(path);

  if (!Hive.isAdapterRegistered(ActivityModelAdapter().typeId)) {
    Hive.registerAdapter(ActivityModelAdapter());
  }
  if (!Hive.isAdapterRegistered(DailyStepModelAdapter().typeId)) {
    Hive.registerAdapter(DailyStepModelAdapter());
  }
  if (!Hive.isAdapterRegistered(WaterModelAdapter().typeId)) {
    Hive.registerAdapter(WaterModelAdapter());
  }
}
