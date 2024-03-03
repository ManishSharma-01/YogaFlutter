import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/data/repository/auth_remote_repository.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return ref.watch(authRemoteRepoProvider);
});

abstract class IAuthRepository {
  Future<Either<Failure, bool>> registerUser(UserEntity user);
  Future<Either<Failure, bool>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
  Future<Either<Failure, List<RoutineEntity>>> getMyRoutine();
  Future<Either<Failure, UserEntity>> getUser(String id);
  Future<Either<Failure, UserEntity>> getMe();
  Future<Either<Failure, bool>> checkUser(String userID);
  Future<Either<Failure, UserEntity>> updateUser(
      String userId, UserEntity user);
}
