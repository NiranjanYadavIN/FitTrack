import 'package:flutter/material.dart';
import 'package:fittrack_mini/data/models/activity_model.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class AddActivityDialog extends StatefulWidget {
  const AddActivityDialog({super.key});

  @override
  State<AddActivityDialog> createState() => _AddActivityDialogState();
}

class _AddActivityDialogState extends State<AddActivityDialog> {
  final _formKey = GlobalKey<FormState>();
  String _type = '';
  int _duration = 0;
  int _calories = 0;
  double _distance = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Activity'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Activity Type'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an activity type';
                }
                return null;
              },
              onSaved: (value) {
                _type = value!;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Duration (minutes)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a duration';
                }
                final duration = int.tryParse(value);
                if (duration == null || duration <= 0) {
                  return 'Please enter a valid duration';
                }
                return null;
              },
              onSaved: (value) {
                _duration = int.parse(value!);
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Calories Burned'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the calories burned';
                }
                final calories = int.tryParse(value);
                if (calories == null || calories <= 0) {
                  return 'Please enter a valid number of calories';
                }
                return null;
              },
              onSaved: (value) {
                _calories = int.parse(value!);
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Distance (km)'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the distance';
                }
                final distance = double.tryParse(value);
                if (distance == null || distance <= 0) {
                  return 'Please enter a valid distance';
                }
                return null;
              },
              onSaved: (value) {
                _distance = double.parse(value!);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final localStorageService =
                  Provider.of<LocalStorageService>(context, listen: false);
              final activity = ActivityModel(
                date: DateTime.now(),
                type: _type,
                duration: _duration,
                calories: _calories,
                distance: _distance,
              );
              localStorageService.activityBox.add(activity);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
