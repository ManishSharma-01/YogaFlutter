import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/data/data_source/routine_remote_data_source.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:fitbit/features/routine/domain/repository/routine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routineRemoteRepoProvider = Provider<IRoutineRepository>(
  (ref) => RoutineRemoteRepositoryImpl(
    routineRemoteDataSource: ref.read(routineRemoteDataSourceProvider),
  ),
);

class RoutineRemoteRepositoryImpl implements IRoutineRepository {
  final RoutineRemoteDataSource routineRemoteDataSource;

  RoutineRemoteRepositoryImpl({required this.routineRemoteDataSource});

  @override
  Future<Either<Failure, bool>> addRoutine(RoutineEntity routine) {
    return routineRemoteDataSource.addRoutine(routine);
  }

  @override
  Future<Either<Failure, bool>> deleteRoutine(String id) {
    return routineRemoteDataSource.deleteRoutine(id);
  }

  @override
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines() {
    return routineRemoteDataSource.getAllRoutines();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsersByRoutine(
      String routineId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoutineEntity>>> getMyRoutines() {
    return routineRemoteDataSource.getMyRoutine();
  }

  @override
  Future<Either<Failure, bool>> updateRoutine(String id) {
    return routineRemoteDataSource.updateRoutine(id);
  }
}
