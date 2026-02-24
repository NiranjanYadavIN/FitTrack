import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/data/models/water_model.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';

void main() {
  group('LocalStorageService', () {
    late LocalStorageService localStorageService;

    setUpAll(() {
      Hive.init('test');
      Hive.registerAdapter(DailyStepModelAdapter());
      Hive.registerAdapter(WaterModelAdapter());
      Hive.registerAdapter(ActivityModelAdapter());
    });

    setUp(() async {
      await Hive.openBox<DailyStepModel>('daily_steps');
      await Hive.openBox<WaterModel>('water_intake');
      await Hive.openBox<ActivityModel>('activities');
      localStorageService = LocalStorageService();
    });

    tearDown(() async {
      await Hive.deleteFromDisk();
    });

    test('save and get daily steps', () async {
      final date = DateTime.now();
      final dailySteps = DailyStepModel(date: date, steps: 100);
      await localStorageService.dailyStepBox.put(date.toIso8601String(), dailySteps);
      final retrievedSteps = localStorageService.dailyStepBox.get(date.toIso8601String());
      expect(retrievedSteps?.steps, 100);
    });

    test('save and get water intake', () async {
      final date = DateTime.now();
      final waterIntake = WaterModel(date: date, amount: 5);
      await localStorageService.waterBox.put(date.toIso8601String(), waterIntake);
      final retrievedWater = localStorageService.waterBox.get(date.toIso8601String());
      expect(retrievedWater?.amount, 5);
    });

    test('save and get activity', () async {
      final activity = ActivityModel(date: DateTime.now(), type: 'Running', duration: 30, distance: 5.0, calories: 300);
      await localStorageService.activityBox.add(activity);
      final activities = localStorageService.activityBox.values.toList();
      expect(activities.length, 1);
      expect(activities.first.type, 'Running');
    });
  });
}
