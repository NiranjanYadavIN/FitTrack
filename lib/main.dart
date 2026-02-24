import 'package:flutter/material.dart';
import 'package:fittrack_mini/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/data/models/water_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(ActivityModelAdapter());
  Hive.registerAdapter(DailyStepModelAdapter());
  Hive.registerAdapter(WaterModelAdapter());

  final dailyStepBox = await Hive.openBox<DailyStepModel>('daily_steps');
  final waterBox = await Hive.openBox<WaterModel>('water_intake');
  final activityBox = await Hive.openBox<ActivityModel>('activities');

  runApp(MyApp(
    dailyStepBox: dailyStepBox,
    waterBox: waterBox,
    activityBox: activityBox,
  ));
}

class MyApp extends StatelessWidget {
  final Box<DailyStepModel> dailyStepBox;
  final Box<WaterModel> waterBox;
  final Box<ActivityModel> activityBox;

  const MyApp({
    Key? key,
    required this.dailyStepBox,
    required this.waterBox,
    required this.activityBox,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocalStorageService(
        dailyStepBox: dailyStepBox,
        waterBox: waterBox,
        activityBox: activityBox,
      ),
      child: MaterialApp(
        title: 'FitTrack Mini',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
