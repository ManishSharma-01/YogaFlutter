import 'dart:io';

import 'package:fitbit/config/router/app_route.dart';
import 'package:fitbit/core/common/snackbar/my_snackbar.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/auth/domain/use_case/auth_usecase.dart';
import 'package:fitbit/features/auth/presentation/state/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.watch(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState.initial());

  Future<void> registerUser(BuildContext context, UserEntity user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showSnackBar(
          message: 'Registered Successfully',
          context: context,
          color: Colors.green,
        );
      },
    );
  }

  Future<void> loginUser(
      BuildContext context, String username, String password) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.loginUser(username, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(
          message: 'Invalid Credentials',
          context: context,
          color: Colors.red,
        );
      },
      (success) async {
        state = state.copyWith(isLoading: false, error: null);
        var userData = await _authUseCase.getUser(username);
        userData.fold(
          (failure) {
            showSnackBar(
              message: 'Failed to get user data',
              context: context,
              color: Colors.red,
            );
          },
          (user) {
            state = state.copyWith(user: user);
            // fetchRoutineData();

            Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
          },
        );
      },
    );
  }

  Future<void> uploadImage(File? file) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.uploadProfilePicture(file!);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }

  getAllUsers() async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.getAllUsers();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, users: r, error: null),
    );
  }

  Future<void> getMe() async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.getMe();

    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
        return null;
      },
      (r) {
        state = state.copyWith(user: r);
        return r;
      },
    );
  }

  // Future<void> fetchRoutineData() async {
  //   state = state.copyWith(isLoading: true);
  //   var data = await _authUseCase.getMyRoutine();

  //   data.fold(
  //     (l) => state = state.copyWith(isLoading: false, error: l.error),
  //     (routines) {
  //       state =
  //           state.copyWith(isLoading: false, routines: routines, error: null);
  //     },
  //   );
  // }

  Future<void> updateUser(
      BuildContext context, String userId, UserEntity user) async {
    state = state.copyWith(isLoading: true);

    var data = await _authUseCase.updateUser(userId, user);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );

        showSnackBar(
          message: failure.error,
          context: context,
          color: Colors.red,
        );
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null, user: user);

        showSnackBar(
          message: 'User Updated successfully',
          context: context,
        );
      },
    );
  }
}
