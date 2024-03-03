import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/core/network/local/hive_service.dart';
import 'package:fitbit/features/routine/data/model/routine_hive_model.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Dependency Injection using Riverpod
final routineLocalDataSourceProvider = Provider<RoutineLocalDataSource>((ref) {
  return RoutineLocalDataSource(
      hiveService: ref.read(hiveServiceProvider),
      routineHiveModel: ref.read(routineHiveModelProvider));
});

class RoutineLocalDataSource {
  final HiveService hiveService;
  final RoutineHiveModel routineHiveModel;

  RoutineLocalDataSource({
    required this.hiveService,
    required this.routineHiveModel,
  });

  // Add Batch
  Future<Either<Failure, bool>> addWorkout(RoutineEntity routine) async {
    try {
      // Convert Entity to Hive Object
      final hiveRoutine = routineHiveModel.toHiveModel(routine);
      // Add to Hive
      await hiveService.addRoutine(hiveRoutine);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, List<RoutineEntity>>> getAllRoutine() async {
    try {
      // Get all batches from Hive
      final routines = await hiveService.getAllRoutines();
      // Convert Hive Object to Entity
      final routineEntities = routineHiveModel.toEntityList(routines);
      return Right(routineEntities);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
