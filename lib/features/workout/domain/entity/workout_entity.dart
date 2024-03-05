import 'package:equatable/equatable.dart';

class WorkoutEntity extends Equatable {
  final String? workoutId;
  final String? image;
  final String title;
  final String nameOfWorkout;
  final String numberOfReps;
  final String day;

  @override
  List<Object?> get props => [
        workoutId,
        title,
        image,
        numberOfReps,
        nameOfWorkout,
        day,
      ];

  const WorkoutEntity({
    this.workoutId,
    this.image,
    required this.title,
    required this.nameOfWorkout,
    required this.numberOfReps,
    required this.day,
  });

  factory WorkoutEntity.fromJson(Map<String, dynamic> json) => WorkoutEntity(
        workoutId: json["workoutId"],
        title: json["title"],
        numberOfReps: json["numberOfReps"],
        nameOfWorkout: json["nameOfWorkout"],
        day: json["day"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "workoutId": workoutId,
        "title": title,
        "nameOfWorkout": nameOfWorkout,
        "numberOfReps": numberOfReps,
        "image": image,
        "day": day,
      };
//last added
  Map<String, dynamic> toMap() {
    return {
      "workoutId": workoutId,
      "day": day,
      "nameOfWorkout": nameOfWorkout,
      "numberOfReps": numberOfReps,
      "title": title,
      // Add other fields if needed
    };
  }
}
