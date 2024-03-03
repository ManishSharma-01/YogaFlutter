import 'package:equatable/equatable.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:fitbit/features/workout/data/model/workout_api_model.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'routine_api_model.g.dart';

final routineApiModelProvider = Provider<RoutineApiModel>(
  (ref) => RoutineApiModel.empty(),
);

@JsonSerializable()
class RoutineApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? routineId;
  final String? user;
  final WorkoutApiModel? workout;
  final String routineStatus;
  final String enrolledAt;
  final String completedAt;

  const RoutineApiModel({
    this.routineId,
    this.user,
    this.workout,
    required this.routineStatus,
    required this.enrolledAt,
    required this.completedAt,
  });

  factory RoutineApiModel.fromJson(Map<String, dynamic> json) =>
      _$RoutineApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineApiModelToJson(this);

  // Named constructor 'empty'
  factory RoutineApiModel.empty() => const RoutineApiModel(
        routineId: '',
        user: '',
        workout: WorkoutApiModel.empty(),
        routineStatus: '',
        enrolledAt: '',
        completedAt: '',
      );

  // Convert API Object to Entity
  RoutineEntity toEntity() => RoutineEntity(
        routineId: routineId ?? '',
        user: UserEntity(
          userID: user ?? '',
          age: '',
          email: '',
          firstname: '',
          gender: '',
          lastname: '',
          password: '',
          username: '',
        ),
        workout: WorkoutEntity(
          workoutId: workout?.workoutId ?? '',
          day: workout?.day ?? '',
          nameOfWorkout: workout?.nameOfWorkout ?? '',
          numberOfReps: workout?.numberOfReps ?? '',
          title: workout?.title ?? '',
        ),
        routineStatus: routineStatus,
        enrolledAt: DateTime.parse(enrolledAt),
        completedAt:
            completedAt.isNotEmpty ? DateTime.tryParse(completedAt) : null,
      );

  // Convert Entity to API Object
  RoutineApiModel fromEntity(RoutineEntity entity) => RoutineApiModel(
        routineId: entity.routineId,
        user: entity.user?.userID,
        workout: WorkoutApiModel(
          workoutId: entity.workout?.workoutId,
          day: entity.workout!.day,
          nameOfWorkout: entity.workout!.nameOfWorkout,
          numberOfReps: entity.workout!.numberOfReps,
          title: entity.workout!.title,
        ),
        routineStatus: entity.routineStatus,
        enrolledAt: entity.enrolledAt.toIso8601String(),
        completedAt: entity.completedAt?.toIso8601String() ?? '',
      );

  // Convert API List to Entity List
  List<RoutineEntity> toEntityList(List<RoutineApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props =>
      [routineId, routineStatus, completedAt, enrolledAt, user];
}
