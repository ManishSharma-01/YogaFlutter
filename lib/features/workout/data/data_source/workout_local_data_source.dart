import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/core/network/local/hive_service.dart';
import 'package:fitbit/features/workout/data/model/workout_hive_model.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dependency Injection using Riverpod
final workoutLocalDataSourceProvider = Provider<WorkoutLocalDataSource>((ref) {
  return WorkoutLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      workoutHiveModel: ref.read(workoutHiveModelProvider));
});

class WorkoutLocalDataSource {
  final HiveService hiveService;
  final WorkoutHiveModel workoutHiveModel;

  WorkoutLocalDataSource({
    required this.hiveService,
    required this.workoutHiveModel,
  });

  // Add Batch
  Future<Either<Failure, bool>> addWorkout(WorkoutEntity workout) async {
    try {
      // Convert Entity to Hive Object
      final hiveWorkout = workoutHiveModel.toHiveModel(workout);
      // Add to Hive
      await hiveService.addWorkout(hiveWorkout);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<WorkoutEntity>>> getAllWorkouts() async {
    try {
      // Get all batches from Hive
      final workouts = await hiveService.getAllWorkouts();
      // Convert Hive Object to Entity
      final workoutEntities = workoutHiveModel.toEntityList(workouts);
      return Right(workoutEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
