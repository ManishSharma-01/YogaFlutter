// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_workout_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllWorkoutDTO _$GetAllWorkoutDTOFromJson(Map<String, dynamic> json) =>
    GetAllWorkoutDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => WorkoutApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllWorkoutDTOToJson(GetAllWorkoutDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
