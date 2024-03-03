import 'package:fitbit/features/workout/data/model/workout_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_workout_dto.g.dart';

@JsonSerializable()
class GetAllWorkoutDTO {
  final bool success;
  final int count;
  final List<WorkoutApiModel> data;

  GetAllWorkoutDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllWorkoutDTOToJson(this);

  factory GetAllWorkoutDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllWorkoutDTOFromJson(json);
}
