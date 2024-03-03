// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_routine_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllRoutineDTO _$GetAllRoutineDTOFromJson(Map<String, dynamic> json) =>
    GetAllRoutineDTO(
      success: json['success'] as bool,
      routines: (json['routines'] as List<dynamic>)
          .map((e) => RoutineApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllRoutineDTOToJson(GetAllRoutineDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'routines': instance.routines,
    };
