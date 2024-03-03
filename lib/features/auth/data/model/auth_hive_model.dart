import 'package:fitbit/config/constants/hive_table_constant.dart';
import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'package:uuid/uuid.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userID;

  @HiveField(1)
  final String firstname;

  @HiveField(2)
  final String lastname;

  @HiveField(3)
  final String email;

  @HiveField(4)
  final String age;

  @HiveField(5)
  final String username;

  @HiveField(6)
  final String gender;

  @HiveField(7)
  final String password;

  // Constructor
  AuthHiveModel({
    String? userID,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.username,
    required this.age,
    required this.gender,
    required this.password,
  }) : userID = userID ?? const Uuid().v4();

  // empty constructor
  AuthHiveModel.empty()
      : this(
          userID: '',
          firstname: '',
          lastname: '',
          email: '',
          age: '',
          gender: '',
          username: '',
          password: '',
        );

  // Convert Hive Object to Entity
  UserEntity toEntity() => UserEntity(
        userID: userID,
        firstname: firstname,
        lastname: lastname,
        age: age,
        gender: gender,
        email: email,
        username: username,
        password: password,
      );

  // Convert Entity to Hive Object
  AuthHiveModel toHiveModel(UserEntity entity) => AuthHiveModel(
        userID: const Uuid().v4(),
        firstname: entity.firstname,
        lastname: entity.lastname,
        age: entity.age,
        gender: entity.gender,
        email: entity.email,
        username: entity.username,
        password: entity.password,
      );

  // Convert Entity List to Hive List
  List<AuthHiveModel> toHiveModelList(List<UserEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userID: $userID, fname: $firstname, lname: $lastname, age: $age, email: $email, gender: $gender, username: $username, password: $password';
  }
}
