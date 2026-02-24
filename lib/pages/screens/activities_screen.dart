import 'package:flutter/material.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<LocalStorageService>(
        builder: (context, localStorageService, child) {
          final activities = localStorageService.activityBox.values.toList();

          if (activities.isEmpty) {
            return const Center(
              child: Text('No activities recorded yet.'),
            );
          }

          return ListView.builder(
            itemCount: activities.length,
            itemBuilder: (context, index) {
              final activity = activities[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(activity.type),
                  subtitle: Text(
                      '${activity.duration} minutes - ${activity.calories} calories'),
                  trailing: Text(
                    activity.date.toIso8601String().substring(0, 10),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
