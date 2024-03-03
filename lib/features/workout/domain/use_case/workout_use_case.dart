import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:fitbit/features/workout/domain/repository/workout_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//watch converted to read
final workoutUsecaseProvider = Provider<WorkoutUseCase>(
  (ref) => WorkoutUseCase(
    workoutRepository: ref.watch(workoutRepositoryProvider),
  ),
);

class WorkoutUseCase {
  final IWorkoutRepository workoutRepository;

  WorkoutUseCase({required this.workoutRepository});

  Future<Either<Failure, List<WorkoutEntity>>> getAllWorkouts() {
    return workoutRepository.getAllWorkouts();
  }

  Future<Either<Failure, WorkoutEntity>> addWorkout(WorkoutEntity workout) {
    return workoutRepository.addWorkout(workout);
  }

  Future<Either<Failure, List<UserEntity>>> getAllUsersByWorkout(
      String workoutId) {
    return workoutRepository.getAllUsersByWorkout(workoutId);
  }

  Future<Either<Failure, bool>> deleteWorkout(String id) async {
    return workoutRepository.deleteWorkout(id);
  }

  Future<Either<Failure, List<WorkoutEntity>>> updateWorkout(
      String id, WorkoutEntity workout) async {
    return workoutRepository.updateWorkout(id, workout);
  }

  Future<Either<Failure, String>> uploadWorkoutPicture(File file) async {
    return await workoutRepository.uploadWorkoutPicture(file);
  }
}
