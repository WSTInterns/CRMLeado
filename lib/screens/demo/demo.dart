import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Activity {
  final String title;
  final String description;
  Activity({required this.title, required this.description});
}

class StepperWithStreamBuilder extends StatefulWidget {
  @override
  _StepperWithStreamBuilderState createState() =>
      _StepperWithStreamBuilderState();
}

class _StepperWithStreamBuilderState
    extends State<StepperWithStreamBuilder> {
  final _streamController = BehaviorSubject<List<Activity>>();
  var _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _streamController.add([
      Activity(
          title: 'Activity 1', description: 'Description for Activity 1')
    ]);
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _addActivity() {
    final currentActivities = _streamController.value ?? [];
    final newActivity = Activity(
      title: 'Activity ${currentActivities.length + 1}',
      description: 'Description for Activity ${currentActivities.length + 1}',
    );
    _streamController.add([...currentActivities, newActivity]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stepper with StreamBuilder'),
      ),
      body: StreamBuilder<List<Activity>>(
        stream: _streamController,
        builder: (context, snapshot) {
          final activities = snapshot.data ?? [];
          _currentStep = _currentStep.clamp(0, activities.length - 1);
          return Stepper(
            currentStep: _currentStep,
            onStepTapped: (index) => setState(() => _currentStep = index),
            steps: activities
                .map((activity) => Step(
                      title: Text(activity.title),
                      content: Text(activity.description),
                    ))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addActivity,
      ),
    );
  }
}
