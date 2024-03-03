import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';

class AuthState {
  final bool isLoading;
  final String? error;
  final String? imageName;
  final List<UserEntity>? users;
  final List<RoutineEntity>? routines;
  UserEntity? user;

  AuthState(
      {required this.isLoading,
      this.error,
      this.imageName,
      this.users,
      this.user,
      this.routines});

  factory AuthState.initial() {
    return AuthState(
      isLoading: false,
      error: null,
      imageName: null,
      users: [],
      routines: [],
      user: null,
    );
  }

  AuthState copyWith({
    bool? isLoading,
    String? error,
    String? imageName,
    List<UserEntity>? users,
    List<RoutineEntity>? routines,
    UserEntity? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
      users: users ?? this.users,
      user: user ?? this.user,
      routines: routines ?? this.routines,
    );
  }

  @override
  String toString() => 'AuthState(isLoading: $isLoading, error: $error)';
}
