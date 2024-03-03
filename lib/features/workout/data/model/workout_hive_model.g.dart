// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutHiveModelAdapter extends TypeAdapter<WorkoutHiveModel> {
  @override
  final int typeId = 1;

  @override
  WorkoutHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutHiveModel(
      workoutId: fields[0] as String?,
      title: fields[1] as String,
      nameOfWorkout: fields[2] as String,
      numberOfReps: fields[3] as String,
      day: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.workoutId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.nameOfWorkout)
      ..writeByte(3)
      ..write(obj.numberOfReps)
      ..writeByte(4)
      ..write(obj.day);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
