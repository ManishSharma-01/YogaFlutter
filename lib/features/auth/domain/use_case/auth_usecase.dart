import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/auth/domain/repository/auth_repository.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(
    ref.read(authRepositoryProvider),
  );
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    return await _authRepository.registerUser(user);
  }

  Future<Either<Failure, bool>> loginUser(
      String username, String password) async {
    return await _authRepository.loginUser(username, password);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await _authRepository.uploadProfilePicture(file);
  }

  Future<Either<Failure, List<UserEntity>>> getAllUsers() {
    return _authRepository.getAllUsers();
  }

  Future<Either<Failure, List<RoutineEntity>>> getMyRoutine() {
    return _authRepository.getMyRoutine();
  }

  Future<Either<Failure, UserEntity>> getUser(String id) {
    return _authRepository.getUser(id);
  }

  Future<Either<Failure, UserEntity>> getMe() {
    return _authRepository.getMe();
  }

  Future<Either<Failure, bool>> checkUser(String userID) async {
    return await _authRepository.checkUser(userID);
  }

  Future<Either<Failure, UserEntity>> updateUser(
      String userId, UserEntity user) async {
    return await _authRepository.updateUser(userId, user);
  }
}
