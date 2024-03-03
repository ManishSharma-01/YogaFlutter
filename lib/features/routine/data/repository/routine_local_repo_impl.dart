import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/data/data_source/routine_local_data_source.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:fitbit/features/routine/domain/repository/routine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routineLocalRepoProvider = Provider<IRoutineRepository>((ref) {
  return RoutineLocalRepositoryImpl(
    routineLocalDataSource: ref.read(routineLocalDataSourceProvider),
  );
});

class RoutineLocalRepositoryImpl implements IRoutineRepository {
  final RoutineLocalDataSource routineLocalDataSource;

  RoutineLocalRepositoryImpl({
    required this.routineLocalDataSource,
  });

  @override
  Future<Either<Failure, bool>> addRoutine(RoutineEntity routine) {
    // TODO: implement addRoutine
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deleteRoutine(String id) {
    // TODO: implement deleteRoutine
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines() {
    // TODO: implement getAllRoutines
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsersByRoutine(
      String routineId) {
    // TODO: implement getAllUsersByRoutine
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoutineEntity>>> getMyRoutines() {
    // TODO: implement getMyRoutines
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updateRoutine(String id) {
    // TODO: implement updateRoutine
    throw UnimplementedError();
  }
}
