import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:fitbit/config/constants/api_endpoint.dart';
import 'package:fitbit/core/failure/failure.dart';
import 'package:fitbit/core/network/remote/http_service.dart';
import 'package:fitbit/core/shared_prefs/user_shared_prefs.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:fitbit/features/routine/data/model/routine_api_model.dart';
import 'package:fitbit/features/routine/domain/entity/routine_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final UserSharedPrefs userSharedPrefs;

  AuthRemoteDataSource({
    required this.userSharedPrefs,
    required this.dio,
  });

  Future<Either<Failure, bool>> registerUser(UserEntity user) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.register,
        data: {
          "firstname": user.firstname,
          "lastname": user.lastname,
          "image": user.image,
          "username": user.username,
          "gender": user.gender,
          "age": user.age,
          "password": user.password,
          "email": user.email,
        },
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

//Login
  Future<Either<Failure, bool>> loginUser(
      String username, String password) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        // retrieve token
        String token = response.data["token"];
        await userSharedPrefs.setUserToken(token);
        getUser(username);

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

  // Upload image using multipart
  Future<Either<Failure, String>> uploadProfilePicture(
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
        ApiEndpoints.uploadImage,
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

// get user when logged in

  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token!);
      String userID = decodedToken['userID'];
      var response = await dio.get(
        ApiEndpoints.getMe + userID,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var userData = response.data;
        if (userData == null) {
          return Left(Failure(error: 'User data is null'));
        }
        var user = UserEntity.fromJson(userData);
        return Right(user);
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

  Future<Either<Failure, UserEntity>> getUser(String userID) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.get(
        ApiEndpoints.getUserbyName + userID,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        var userData = response.data['data'];
        if (userData == null) {
          return Left(Failure(error: 'User data is null'));
        }
        var user = UserEntity.fromJson(userData);
        return Right(user);
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

  Future<Either<Failure, List<RoutineEntity>>> getMyRoutine() async {
  try {
    // Get the token from shared prefs
    String? token;
    var data = await userSharedPrefs.getUserToken();
    data.fold(
      (l) => token = null,
      (r) => token = r,
    );

    var response = await dio.get(
      ApiEndpoints.getMyRoutine,
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      var jsonData = response.data; // The response data is already a Map
      var routinesData = jsonData['routines'] as List<dynamic>?;

      if (routinesData != null) {
        var routines = routinesData
            .map((routine) => RoutineApiModel.fromJson(routine))
            .toList();

        var entities = routines
            .map((routine) => routine.toEntity())
            .toList(); // Convert to RoutineEntity list

        return Right(entities); // Wrap the result in Right constructor
      } else {
        return Left(
          Failure(
            error: "No routines found",
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } else {
      return Left(
        Failure(
          error: response.statusMessage ?? '',
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

  Future<Either<Failure, UserEntity>> updateUser(
      String userId, UserEntity user) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.updateUser + userId,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "firstname": user.firstname,
          "lastname": user.lastname,
          "image": user.image,
          "gender": user.gender,
          "age": user.age,
          "email": user.email,
          "username": user.username,
        },
      );

      if (response.statusCode == 200) {
        var userData = response.data;
        if (userData == null) {
          return Left(Failure(error: 'User data is null'));
        }
        var updatedUser = UserEntity.fromJson(userData);
        return Right(updatedUser);
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
