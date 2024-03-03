import 'package:equatable/equatable.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';

class RoutineEntity extends Equatable {
  final String? routineId;
  final WorkoutEntity? workout;
  final UserEntity? user;
  final String routineStatus;
  final DateTime enrolledAt;
  final DateTime? completedAt;

  @override
  List<Object?> get props => [
        routineId,
        workout,
        user,
        routineStatus,
        enrolledAt,
        completedAt,
      ];

  const RoutineEntity({
    this.routineId,
    required this.workout,
    required this.user,
    required this.routineStatus,
    required this.enrolledAt,
    required this.completedAt,
  });

  RoutineEntity copyWith({
    String? routineId,
    UserEntity? user,
    WorkoutEntity? workout,
    String? enrolledAt,
    String? routineStatus,
    DateTime? completedAt,
  }) {
    return RoutineEntity(
      routineId: routineId ?? this.routineId,
      user: user ?? this.user,
      workout: workout ?? this.workout,
      enrolledAt:
          enrolledAt != null ? DateTime.parse(enrolledAt) : this.enrolledAt,
      routineStatus: routineStatus ?? this.routineStatus,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  factory RoutineEntity.fromJson(Map<String, dynamic> json) => RoutineEntity(
        routineId: json["_id"],
        workout: json["workout"],
        user: json["user"],
        routineStatus: json["routineStatus"],
        enrolledAt: json["enrolledAt"],
        completedAt: json["completedAt"],
      );

  Map<String, dynamic> toJson() => {
        "_id": routineId,
        "workout": workout,
        "user": user,
        "routineStatus": routineStatus,
        "enrolledAt": enrolledAt,
        "completedAt": completedAt,
      };
}
