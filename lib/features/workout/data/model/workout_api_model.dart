import 'package:equatable/equatable.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

part 'workout_api_model.g.dart';

final workoutApiModelProvider = Provider<WorkoutApiModel>(
  (ref) => const WorkoutApiModel.empty(),
);

@JsonSerializable()
class WorkoutApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? workoutId;
  final String title;
  final String nameOfWorkout;
  final String numberOfReps;
  final String day;
  final String? image;

  const WorkoutApiModel({
    this.image,
    required this.workoutId,
    required this.title,
    required this.nameOfWorkout,
    required this.numberOfReps,
    required this.day,
  });
  const WorkoutApiModel.empty()
      : workoutId = '',
        nameOfWorkout = '',
        title = '',
        numberOfReps = '',
        image = '',
        day = '';

  Map<String, dynamic> toJson() => _$WorkoutApiModelToJson(this);

  factory WorkoutApiModel.fromJson(Map<String, dynamic> json) =>
      _$WorkoutApiModelFromJson(json);

  // Convert API Object to Entity
  WorkoutEntity toEntity() => WorkoutEntity(
      workoutId: workoutId,
      nameOfWorkout: nameOfWorkout,
      numberOfReps: numberOfReps,
      day: day,
      image: image,
      title: title);

  // Convert Entity to API Object
  WorkoutApiModel fromEntity(WorkoutEntity entity) => WorkoutApiModel(
        workoutId: entity.workoutId ?? '',
        nameOfWorkout: entity.nameOfWorkout,
        numberOfReps: entity.numberOfReps,
        day: entity.day,
        title: entity.title,
        image: entity.image,
      );

  // Convert API List to Entity List
  List<WorkoutEntity> toEntityList(List<WorkoutApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props =>
      [workoutId, title, nameOfWorkout, numberOfReps, day];
}
