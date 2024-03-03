import 'package:fitbit/features/auth/data/model/auth_api_model.dart';
import 'package:fitbit/features/workout/data/model/workout_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_user_by_workout.g.dart';

@JsonSerializable()
class GetAllUserByWorkoutDTO {
  final bool success;
  final String message;
  final List<WorkoutApiModel> data;

  GetAllUserByWorkoutDTO({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetAllUserByWorkoutDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllUserByWorkoutDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllUserByWorkoutDTOToJson(this);
}
