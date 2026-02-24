import 'package:flutter_test/flutter_test.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/data/models/water_model.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';
import 'package:hive/hive.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() async {
    await setupTestHive();
  });

  group('LocalStorageService', () {
    late LocalStorageService localStorageService;
    late Box<DailyStepModel> dailyStepBox;
    late Box<WaterModel> waterBox;
    late Box<ActivityModel> activityBox;

    setUp(() async {
      dailyStepBox = await Hive.openBox<DailyStepModel>('daily_steps_test');
      waterBox = await Hive.openBox<WaterModel>('water_intake_test');
      activityBox = await Hive.openBox<ActivityModel>('activities_test');
      localStorageService = LocalStorageService(
          dailyStepBox: dailyStepBox,
          waterBox: waterBox,
          activityBox: activityBox);
    });

    tearDown(() async {
      await dailyStepBox.clear();
      await waterBox.clear();
      await activityBox.clear();
    });

    test('save and get daily steps', () async {
      final date = DateTime.now();
      final dailySteps = DailyStepModel(date: date, steps: 100);
      await localStorageService.dailyStepBox.put(date.toIso8601String(), dailySteps);
      final retrievedSteps =
          localStorageService.dailyStepBox.get(date.toIso8601String());
      expect(retrievedSteps?.steps, 100);
    });

    test('save and get water intake', () async {
      final date = DateTime.now();
      final waterIntake = WaterModel(date: date, amount: 5);
      await localStorageService.waterBox.put(date.toIso8601String(), waterIntake);
      final retrievedWater =
          localStorageService.waterBox.get(date.toIso8601String());
      expect(retrievedWater?.amount, 5);
    });

    test('save and get activity', () async {
      final activity = ActivityModel(
          date: DateTime.now(),
          type: 'Running',
          duration: 30,
          distance: 5.0,
          calories: 300);
      await localStorageService.activityBox.add(activity);
      final activities = localStorageService.activityBox.values.toList();
      expect(activities.length, 1);
      expect(activities.first.type, 'Running');
    });
  });
}
