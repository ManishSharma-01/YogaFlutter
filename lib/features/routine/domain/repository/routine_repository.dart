import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/data/repository/routine_remote_repo_impl.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routineRepositoryProvider = Provider<IRoutineRepository>(
  (ref) {
    return ref.watch(routineRemoteRepoProvider);
  },
);

abstract class IRoutineRepository {
  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines();
  Future<Either<Failure, List<RoutineEntity>>> getMyRoutines();
  Future<Either<Failure, bool>> addRoutine(RoutineEntity routine);
  Future<Either<Failure, List<UserEntity>>> getAllUsersByRoutine(
      String routineId);
  Future<Either<Failure, bool>> deleteRoutine(String id);
  Future<Either<Failure, bool>> updateRoutine(String id);
}
