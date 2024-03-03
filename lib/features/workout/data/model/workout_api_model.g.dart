// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutApiModel _$WorkoutApiModelFromJson(Map<String, dynamic> json) =>
    WorkoutApiModel(
      image: json['image'] as String?,
      workoutId: json['_id'] as String?,
      title: json['title'] as String,
      nameOfWorkout: json['nameOfWorkout'] as String,
      numberOfReps: json['numberOfReps'] as String,
      day: json['day'] as String,
    );

Map<String, dynamic> _$WorkoutApiModelToJson(WorkoutApiModel instance) =>
    <String, dynamic>{
      '_id': instance.workoutId,
      'title': instance.title,
      'nameOfWorkout': instance.nameOfWorkout,
      'numberOfReps': instance.numberOfReps,
      'day': instance.day,
      'image': instance.image,
    };
