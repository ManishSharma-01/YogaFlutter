// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineHiveModelAdapter extends TypeAdapter<RoutineHiveModel> {
  @override
  final int typeId = 2;

  @override
  RoutineHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RoutineHiveModel(
      routineId: fields[0] as String?,
      workout: fields[1] as WorkoutHiveModel,
      user: fields[2] as AuthHiveModel,
      routineStatus: fields[3] as String,
      enrolledAt: fields[4] as DateTime,
      completedAt: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, RoutineHiveModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.routineId)
      ..writeByte(1)
      ..write(obj.workout)
      ..writeByte(2)
      ..write(obj.user)
      ..writeByte(3)
      ..write(obj.routineStatus)
      ..writeByte(4)
      ..write(obj.enrolledAt)
      ..writeByte(5)
      ..write(obj.completedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
