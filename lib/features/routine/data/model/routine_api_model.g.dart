// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineApiModel _$RoutineApiModelFromJson(Map<String, dynamic> json) =>
    RoutineApiModel(
      routineId: json['_id'] as String?,
      user: json['user'] as String?,
      workout: json['workout'] == null
          ? null
          : WorkoutApiModel.fromJson(json['workout'] as Map<String, dynamic>),
      routineStatus: json['routineStatus'] as String,
      enrolledAt: json['enrolledAt'] as String,
      completedAt: json['completedAt'] as String,
    );

Map<String, dynamic> _$RoutineApiModelToJson(RoutineApiModel instance) =>
    <String, dynamic>{
      '_id': instance.routineId,
      'user': instance.user,
      'workout': instance.workout,
      'routineStatus': instance.routineStatus,
      'enrolledAt': instance.enrolledAt,
      'completedAt': instance.completedAt,
    };
