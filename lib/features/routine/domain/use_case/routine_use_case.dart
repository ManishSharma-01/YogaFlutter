import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:fitbit/features/routine/domain/repository/routine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routineUsecaseProvider = Provider<RoutineUseCase>(
  (ref) => RoutineUseCase(
    routineRepository: ref.watch(routineRepositoryProvider),
  ),
);

class RoutineUseCase {
  final IRoutineRepository routineRepository;

  RoutineUseCase({required this.routineRepository});

  Future<Either<Failure, List<RoutineEntity>>> getAllRoutines() {
    return routineRepository.getAllRoutines();
  }

  Future<Either<Failure, List<RoutineEntity>>> getMyRoutines() {
    return routineRepository.getMyRoutines();
  }

  Future<Either<Failure, bool>> addRoutine(RoutineEntity routine) {
    return routineRepository.addRoutine(routine);
  }

  Future<Either<Failure, List<UserEntity>>> getAllUsersByWorkout(
      String workoutId) {
    throw UnimplementedError();
  }

  Future<Either<Failure, bool>> deleteRoutine(String id) async {
    return routineRepository.deleteRoutine(id);
  }

  Future<Either<Failure, bool>> updateRoutine(String id) async {
    return routineRepository.updateRoutine(id);
  }
}
