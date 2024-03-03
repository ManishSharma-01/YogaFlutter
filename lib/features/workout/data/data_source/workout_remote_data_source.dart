import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitbit/config/constants/api_endpoint.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/core/network/remote/http_service.dart';
import 'package:fitbit/core/shared_prefs/user_shared_prefs.dart';
import 'package:fitbit/features/workout/data/dto/get_all_workout_dto.dart';
import 'package:fitbit/features/workout/data/model/workout_api_model.dart';
import 'package:fitbit/features/workout/domain/entity/workout_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final workoutRemoteDataSourceProvider = Provider(
  (ref) => WorkoutRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    workoutApiModel: ref.read(workoutApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class WorkoutRemoteDataSource {
  final Dio dio;
  final WorkoutApiModel workoutApiModel;
  final UserSharedPrefs userSharedPrefs;

  WorkoutRemoteDataSource({
    required this.dio,
    required this.workoutApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, WorkoutEntity>> addWorkout(
      WorkoutEntity workout) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.post(
        ApiEndpoints.createWorkout,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "title": workout.title,
          "nameOfWorkout": workout.nameOfWorkout,
          "image": workout.image,
          "day": workout.day,
          "numberOfReps": workout.numberOfReps,
        },
      );

      if (response.statusCode == 201) {
        return Right(WorkoutEntity.fromJson(response.data["data"]));
      } else {
        return Left(
          Failure(
            error: response.data['message'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.message.toString(),
        ),
      );
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadWorkoutPicture(
    File image,
  ) async {
    try {
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadWorkoutImage,
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, List<WorkoutEntity>>> getAllWorkouts() async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      var response = await dio.get(
        ApiEndpoints.getAllWorkout,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        // OR
        // 2nd way
        GetAllWorkoutDTO workoutAddDTO =
            GetAllWorkoutDTO.fromJson(response.data);
        return Right(workoutApiModel.toEntityList(workoutAddDTO.data));
      } else {
        return Left(
          Failure(
            error: response.statusMessage.toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteWorkout(String workoutId) async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      Response response = await dio.delete(
        ApiEndpoints.deleteworkout + workoutId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  // Future<Either<Failure, bool>> updateWorkout(String workoutId) async {
  //   try {
  //     // Get the token from shared prefs
  //     String? token;
  //     var data = await userSharedPrefs.getUserToken();
  //     data.fold(
  //       (l) => token = null,
  //       (r) => token = r!,
  //     );

  //     Response response = await dio.put(
  //       ApiEndpoints.updateWorkout + workoutId,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //         },
  //       ),
  //     );
  //     if (response.statusCode == 200) {
  //       return const Right(true);
  //     } else {
  //       return Left(
  //         Failure(
  //           error: response.data["message"],
  //           statusCode: response.statusCode.toString(),
  //         ),
  //       );
  //     }
  //   } on DioException catch (e) {
  //     return Left(
  //       Failure(
  //         error: e.error.toString(),
  //         statusCode: e.response?.statusCode.toString() ?? '0',
  //       ),
  //     );
  //   }
  // }

  Future<Either<Failure, List<WorkoutEntity>>> updateWorkout(
      String workoutId, WorkoutEntity workout) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.updateWorkout + workoutId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "title": workout.title,
          "nameOfWorkout": workout.nameOfWorkout,
          "day": workout.day,
          "numberOfReps": workout.numberOfReps,
          "image": workout.image,
        },
      );

      if (response.statusCode == 200) {
        var workouts = (response.data['data'] as List)
            .map((workout) => WorkoutApiModel.fromJson(workout).toEntity())
            .toList();
        return Right(workouts);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
