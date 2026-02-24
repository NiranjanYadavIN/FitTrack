import 'package:flutter/material.dart';
import 'package:fittrack_mini/data/models/water_model.dart';
import 'package:fittrack_mini/services/local_storage_service.dart';
import 'package:provider/provider.dart';

class AddWaterDialog extends StatefulWidget {
  const AddWaterDialog({super.key});

  @override
  State<AddWaterDialog> createState() => _AddWaterDialogState();
}

class _AddWaterDialogState extends State<AddWaterDialog> {
  final _formKey = GlobalKey<FormState>();
  int _amount = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Water'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Amount (glasses)',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an amount';
            }
            final amount = int.tryParse(value);
            if (amount == null || amount <= 0) {
              return 'Please enter a valid amount';
            }
            return null;
          },
          onSaved: (value) {
            _amount = int.parse(value!);
          },
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
              final today = DateTime.now();
              final todayString = today.toIso8601String().substring(0, 10);
              final waterIntake = localStorageService.waterBox.get(todayString) ??
                  WaterModel(date: today, amount: 0);
              waterIntake.amount += _amount;
              localStorageService.waterBox.put(todayString, waterIntake);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
