import 'package:fitbit/config/constants/hive_table_constant.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'workout_hive_model.g.dart';

final workoutHiveModelProvider = Provider(
  (ref) => WorkoutHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.workoutTableId)
class WorkoutHiveModel {
  @HiveField(0)
  final String workoutId;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String nameOfWorkout;

  @HiveField(3)
  final String numberOfReps;

  @HiveField(4)
  final String day;

  // empty constructor
  WorkoutHiveModel.empty()
      : this(
            workoutId: '',
            title: '',
            nameOfWorkout: '',
            numberOfReps: '',
            day: '');

  WorkoutHiveModel({
    String? workoutId,
    required this.title,
    required this.nameOfWorkout,
    required this.numberOfReps,
    required this.day,
  }) : workoutId = workoutId ?? const Uuid().v4();

  // Convert Hive Object to Entity
  WorkoutEntity toEntity() => WorkoutEntity(
        workoutId: workoutId,
        title: title,
        nameOfWorkout: nameOfWorkout,
        numberOfReps: numberOfReps,
        day: day,
      );

  // Convert Entity to Hive Object
  WorkoutHiveModel toHiveModel(WorkoutEntity entity) => WorkoutHiveModel(
        // workoutId: entity.workoutId,
        title: entity.title,
        nameOfWorkout: entity.nameOfWorkout,
        numberOfReps: entity.numberOfReps,
        day: entity.day,
      );

  // Convert Hive List to Entity List
  List<WorkoutEntity> toEntityList(List<WorkoutHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'workoutId: $workoutId, title: $title';
  }
}
