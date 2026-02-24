import 'package:flutter/material.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitTrack Mini'),
      ),
      body: Consumer<LocalStorageService>(
        builder: (context, localStorageService, child) {
          final today = DateTime.now();
          final dailySteps = localStorageService.dailyStepBox.get(today.toIso8601String());
          final waterIntake = localStorageService.waterBox.get(today.toIso8601String());
          final activities = localStorageService.activityBox.values.toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Today\'s Steps: ${dailySteps?.steps ?? 0}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Water Intake: ${waterIntake?.amount ?? 0} glasses',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                Text(
                  'Recent Activities',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      final activity = activities[index];
                      return ListTile(
                        title: Text(activity.type),
                        subtitle: Text('${activity.duration} minutes - ${activity.calories} calories'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
