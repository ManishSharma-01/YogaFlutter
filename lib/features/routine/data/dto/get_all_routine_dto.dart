import 'package:fitbit/features/routine/data/model/routine_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_routine_dto.g.dart';

@JsonSerializable()
class GetAllRoutineDTO {
  final bool success;
  final List<RoutineApiModel> routines;

  GetAllRoutineDTO({
    required this.success,
    required this.routines,
  });

  Map<String, dynamic> toJson() => _$GetAllRoutineDTOToJson(this);

  factory GetAllRoutineDTO.fromJson(Map<String, dynamic> json) {
    return GetAllRoutineDTO(
      success: json['success'] ?? false,
      routines: json['routines'] != null
          ? (json['routines'] as List).map((routineJson) {
              // Convert date-time strings to String
              routineJson['enrolledAt'] = routineJson['enrolledAt'].toString();
              routineJson['completedAt'] =
                  routineJson['completedAt'].toString();
              return RoutineApiModel.fromJson(routineJson);
            }).toList()
          : [],
    );
  }
}
