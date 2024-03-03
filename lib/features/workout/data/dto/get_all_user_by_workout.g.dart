// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_user_by_workout.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllUserByWorkoutDTO _$GetAllUserByWorkoutDTOFromJson(
        Map<String, dynamic> json) =>
    GetAllUserByWorkoutDTO(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => WorkoutApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllUserByWorkoutDTOToJson(
        GetAllUserByWorkoutDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
