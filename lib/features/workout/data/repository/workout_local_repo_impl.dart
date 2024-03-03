import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/workout/data/data_source/workout_local_data_source.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:fitbit/features/workout/domain/repository/workout_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutLocalRepoProvider = Provider<IWorkoutRepository>((ref) {
  return WorkoutLocalRepositoryImpl(
    workoutLocalDataSource: ref.read(workoutLocalDataSourceProvider),
  );
});

class WorkoutLocalRepositoryImpl implements IWorkoutRepository {
  final WorkoutLocalDataSource workoutLocalDataSource;

  WorkoutLocalRepositoryImpl({
    required this.workoutLocalDataSource,
  });

  @override
  Future<Either<Failure, WorkoutEntity>> addWorkout(WorkoutEntity workout) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<WorkoutEntity>>> getAllWorkouts() {
    return workoutLocalDataSource.getAllWorkouts();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsersByWorkout(
      String batchId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteWorkout(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> uploadWorkoutPicture(File file) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<WorkoutEntity>>> updateWorkout(
      String id, WorkoutEntity wss) {
    throw UnimplementedError();
  }
}
