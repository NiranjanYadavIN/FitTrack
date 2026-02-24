import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fittrack_mini/data/models/daily_step_model.dart';
import 'package:fittrack_mini/pages/dialogs/add_water_dialog.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Stream<StepCount> _stepCountStream;
  late StreamSubscription<StepCount> _stepCountSubscription;

  @override
  void initState() {
    super.initState();
    initPedometer();
  }

  void initPedometer() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountSubscription = _stepCountStream.listen(onStepCount)
      ..onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    final localStorageService =
        Provider.of<LocalStorageService>(context, listen: false);
    final today = DateTime.now();
    final todayString = today.toIso8601String().substring(0, 10);
    final dailyStep = DailyStepModel(
      date: today,
      steps: event.steps,
    );
    localStorageService.dailyStepBox.put(todayString, dailyStep);
  }

  void onStepCountError(Object error) {
    debugPrint('Pedometer Error: $error');
  }

  @override
  void dispose() {
    _stepCountSubscription.cancel();
    super.dispose();
  }

  void _showAddWaterDialog() {
    showDialog(
      context: context,
      builder: (context) => const AddWaterDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocalStorageService>(
        builder: (context, localStorageService, child) {
          final today = DateTime.now();
          final todayString = today.toIso8601String().substring(0, 10);
          final dailySteps = localStorageService.dailyStepBox.get(todayString);
          final waterIntake = localStorageService.waterBox.get(todayString);
          final activities = localStorageService.activityBox.values.toList();

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircularPercentIndicator(
                      radius: 120.0,
                      lineWidth: 13.0,
                      animation: true,
                      percent: (dailySteps?.steps ?? 0) / 10000,
                      center: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.directions_walk, size: 50),
                          Text(
                            '${dailySteps?.steps ?? 0}',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const Text('steps'),
                        ],
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.local_drink),
                      title: const Text('Water Intake'),
                      subtitle: Text('${waterIntake?.amount ?? 0} glasses'),
                      trailing: const Icon(Icons.add),
                      onTap: _showAddWaterDialog,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Recent Activities',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];
                      return Card(
                        child: ListTile(
                          title: Text(activity.type),
                          subtitle: Text(
                              '${activity.duration} minutes - ${activity.calories} calories'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
