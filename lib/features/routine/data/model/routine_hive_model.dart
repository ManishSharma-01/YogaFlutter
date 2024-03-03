import 'package:fitbit/config/constants/hive_table_constant.dart';
import 'package:fitbit/features/auth/data/model/auth_hive_model.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:fitbit/features/workout/data/model/workout_hive_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'routine_hive_model.g.dart';

final routineHiveModelProvider = Provider(
  (ref) => RoutineHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.routineTableId)
class RoutineHiveModel {
  @HiveField(0)
  final String routineId;

  @HiveField(1)
  final WorkoutHiveModel workout;

  @HiveField(2)
  final AuthHiveModel user;

  @HiveField(3)
  final String routineStatus;

  @HiveField(4)
  final DateTime enrolledAt;

  @HiveField(5)
  final DateTime? completedAt;

  // empty constructor
  RoutineHiveModel.empty()
      : this(
          routineId: '',
          workout: WorkoutHiveModel.empty(),
          user: AuthHiveModel.empty(),
          routineStatus: '',
          enrolledAt: DateTime.now(),
          completedAt: null,
        );

  RoutineHiveModel({
    String? routineId,
    required this.workout,
    required this.user,
    required this.routineStatus,
    required this.enrolledAt,
    this.completedAt,
  }) : routineId = routineId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  RoutineEntity toEntity() => RoutineEntity(
        routineId: routineId,
        user: user.toEntity(),
        workout: workout.toEntity(),
        routineStatus: routineStatus,
        enrolledAt: enrolledAt,
        completedAt: completedAt,
      );

  // Convert Entity to Hive Object
  RoutineHiveModel toHiveModel(RoutineEntity entity) => RoutineHiveModel(
        routineId: entity.routineId,
        user: AuthHiveModel.empty().toHiveModel(entity.user!),
        routineStatus: entity.routineStatus,
        workout: WorkoutHiveModel.empty().toHiveModel(entity.workout!),
        enrolledAt: entity.enrolledAt,
        completedAt: entity.completedAt,
      );

// Convert Hive List to Entity List
  List<RoutineEntity> toEntityList(List<RoutineHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'routineId: $routineId, status: $routineStatus';
  }
}
