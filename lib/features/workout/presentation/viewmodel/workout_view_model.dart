import 'dart:io';

import 'package:fitbit/core/common/snackbar/my_snackbar.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:fitbit/features/workout/domain/use_case/workout_use_case.dart';
import 'package:fitbit/features/workout/presentation/state/workout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutViewModelProvider =
    StateNotifierProvider<WorkoutViewModel, WorkoutState>(
  (ref) {
    return WorkoutViewModel(ref.read(workoutUsecaseProvider));
  },
);

class WorkoutViewModel extends StateNotifier<WorkoutState> {
  final WorkoutUseCase workoutUseCase;

  WorkoutViewModel(this.workoutUseCase) : super(WorkoutState.initial()) {
    getAllWorkouts();
  }

  Future<void> addWorkout(WorkoutEntity workout) async {
    state = state.copyWith(isLoading: true);
    var data = await workoutUseCase.addWorkout(workout);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(
          isLoading: false,
          workouts: [...state.workouts, r],
          error: null,
        );
      },
    );
  }

  getAllWorkouts() async {
    state = state.copyWith(isLoading: true);
    var data = await workoutUseCase.getAllWorkouts();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, workouts: r, error: null),
    );
  }

  Future<void> deleteWorkout(
      BuildContext context, WorkoutEntity workout) async {
    state.copyWith(isLoading: true);
    var data = await workoutUseCase.deleteWorkout(workout.workoutId!);
    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state.workouts.remove(workout);
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Workout delete successfully',
          context: context,
        );
      },
    );
  }

  updateWorkout(
      BuildContext context, String workoutId, WorkoutEntity workout) async {
    state = state.copyWith(isLoading: true);

    var data = await workoutUseCase.updateWorkout(workoutId, workout);

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(workouts: r, error: null, isLoading: false);
        getAllWorkouts();
      },
    );
  }

  // Future<void> updateWorkout(
  //     BuildContext context, String workoutId, WorkoutEntity workout) async {
  //   state = state.copyWith(isLoading: true);

  //   var data = await workoutUseCase.updateWorkout(workoutId, workout);

  //   data.fold(
  //     (failure) {
  //       state = state.copyWith(
  //         isLoading: false,
  //         error: failure.error,
  //       );

  //       showSnackBar(
  //         message: failure.error,
  //         context: context,
  //         color: Colors.red,
  //       );
  //     },
  //     (success) async {
  //       final allWorkoutsData = await workoutUseCase.getAllWorkouts();

  //       allWorkoutsData.fold(
  //         (l) {
  //           state = state.copyWith(isLoading: false, error: l.error);
  //         },
  //         (workouts) {
  //           state = state.copyWith(
  //             isLoading: false,
  //             error: null,
  //             workouts: workouts,
  //           );

  //           showSnackBar(
  //             message: 'Workout Updated successfully',
  //             context: context,
  //           );
  //         },
  //       );
  //     },
  //   );

  // }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await workoutUseCase.uploadWorkoutPicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (image) {
        state = state.copyWith(isLoading: false, error: null, image: image);
      },
    );
  }
}
