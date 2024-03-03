import 'package:fitbit/features/workout/presentation/viewmodel/workout_view_model.dart';
import 'package:fitbit/features/workout/presentation/widget/load_workout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WorkoutPlansView extends ConsumerWidget {
  const WorkoutPlansView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var gap = const SizedBox(
      height: 20,
    );

    var workoutState = ref.watch(workoutViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Plans'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Search',
                suffixIcon: Icon(
                  Icons.search,
                ),
              ),
            ),
            gap,
            if (workoutState.isLoading) ...{
              const CircularProgressIndicator(),
            } else if (workoutState.error != null) ...{
              Text(workoutState.error!),
            } else if (workoutState.workouts.isEmpty) ...{
              const Text('No workouts available.'),
            } else ...{
              Expanded(
                child: LoadWorkout(
                  lstWorkout: workoutState.workouts,
                  ref: ref,
                ),
              ),
            },
          ],
        ),
      ),
    );
  }
}
