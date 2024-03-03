import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/auth/domain/repository/auth_repository.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginUser(String username, String password) {
    return _authLocalDataSource.loginUser(username, password);
  }

  @override
  Future<Either<Failure, bool>> registerUser(UserEntity user) {
    return _authLocalDataSource.registerUser(user);
  }

  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> checkUser(String userID) {
    // TODO: implement checkUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() {
    // TODO: implement getMe
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RoutineEntity>>> getMyRoutine() {
    // TODO: implement getMyRoutine
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, UserEntity>> updateUser(String user, UserEntity dd) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
