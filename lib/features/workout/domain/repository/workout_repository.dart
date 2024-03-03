import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitbit/core/common/provider/internet_connectivity.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/workout/data/repository/workout_local_repo_impl.dart';
import 'package:fitbit/features/workout/data/repository/workout_remote_repo_impl.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutRepositoryProvider = Provider<IWorkoutRepository>(
  (ref) {
    // // Check for the internet
    final internetStatus = ref.watch(connectivityStatusProvider);

    if (ConnectivityStatus.isConnected == internetStatus) {
      // If internet is available then return remote repo
      return ref.watch(workoutRemoteRepoProvider);
    } else {
      // If internet is not available then return local repo
      return ref.watch(workoutLocalRepoProvider);
    }
  },
);

abstract class IWorkoutRepository {
  Future<Either<Failure, List<WorkoutEntity>>> getAllWorkouts();
  Future<Either<Failure, WorkoutEntity>> addWorkout(WorkoutEntity workout);
  Future<Either<Failure, List<UserEntity>>> getAllUsersByWorkout(
      String workoutId);
  Future<Either<Failure, bool>> deleteWorkout(String id);
  Future<Either<Failure, List<WorkoutEntity>>> updateWorkout(
      String id, WorkoutEntity workout);
  Future<Either<Failure, String>> uploadWorkoutPicture(File file);
}
