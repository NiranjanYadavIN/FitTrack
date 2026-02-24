import 'package:flutter_test/flutter_test.dart';
import 'package:fittrack_mini/main.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/data/models/water_model.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() async {
    await setupTestHive();
  });

  testWidgets('App title is displayed', (WidgetTester tester) async {
    // Open boxes for testing
    final dailyStepBox = await Hive.openBox<DailyStepModel>('daily_steps_widget_test');
    final waterBox = await Hive.openBox<WaterModel>('water_intake_widget_test');
    final activityBox = await Hive.openBox<ActivityModel>('activities_widget_test');

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => LocalStorageService(
          dailyStepBox: dailyStepBox,
          waterBox: waterBox,
          activityBox: activityBox,
        ),
        child: MyApp(
          dailyStepBox: dailyStepBox,
          waterBox: waterBox,
          activityBox: activityBox,
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Verify that the app title is displayed.
    expect(find.text('FitTrack Mini'), findsOneWidget);

    // Clean up the boxes
    await dailyStepBox.close();
    await waterBox.close();
    await activityBox.close();
  });
}
