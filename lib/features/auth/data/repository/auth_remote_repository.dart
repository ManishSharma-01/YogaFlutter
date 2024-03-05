import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/auth/domain/repository/auth_repository.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepoProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(ref.read(authRemoteDataSourceProvider));
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRemoteRepository(this._authRemoteDataSource);
  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return _authRemoteDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authRemoteDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    return _authRemoteDataSource.uploadProfilePicture(file);
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) {
    return _authRemoteDataSource.getUser(id);
  }

  @override
  Future<Either<Failure, bool>> checkUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() {
    return _authRemoteDataSource.getMe();
  }

  @override
  Future<Either<Failure, List<RoutineEntity>>> getMyRoutine() {
    return _authRemoteDataSource.getMyRoutine();
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(
      String userId, UserEntity user) {
    return _authRemoteDataSource.updateUser(userId, user);
  }
}
