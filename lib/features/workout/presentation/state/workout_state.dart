import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';

class WorkoutState {
  final bool isLoading;
  final List<WorkoutEntity> workouts;
  final List<WorkoutEntity> updateWorkout;
  final List<UserEntity>? users;
  final String? error;
  final String? image;
  WorkoutEntity? workout;

  WorkoutState({
    this.users,
    required this.isLoading,
    required this.workouts,
    this.error,
    this.image,
    this.workout,
    required this.updateWorkout,
  });

  factory WorkoutState.initial() {
    return WorkoutState(
      isLoading: false,
      users: [],
      workouts: [],
      image: null,
      workout: null,
      updateWorkout: [],
    );
  }

  WorkoutState copyWith({
    bool? isLoading,
    List<WorkoutEntity>? workouts,
    List<UserEntity>? users,
    String? error,
    String? image,
    WorkoutEntity? workout,
    List<WorkoutEntity>? updateWorkout,
  }) {
    return WorkoutState(
      isLoading: isLoading ?? this.isLoading,
      workouts: workouts ?? this.workouts,
      workout: workout ?? this.workout,
      users: users ?? this.users,
      error: error ?? this.error,
      image: image ?? this.image,
      updateWorkout: updateWorkout ?? this.updateWorkout,
    );
  }
}
