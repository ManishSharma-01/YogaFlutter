import 'package:fitbit/features/auth/domain/entity/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? userID;
  final String firstname;
  final String lastname;
  final String? image;
  final String email;
  final String age;
  final String gender;
  final String username;
  final String password;

  AuthApiModel({
    this.userID,
    required this.firstname,
    required this.lastname,
    this.image,
    required this.age,
    required this.email,
    required this.gender,
    required this.username,
    required this.password,
  });

  AuthApiModel.empty()
      : this(
          firstname: '',
          lastname: '',
          email: '',
          age: '',
          gender: '',
          username: '',
          password: '',
          image: '',
          userID: '',
        );

  // factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$AuthApiModelFromJson(json);

  // Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // convert AuthApiModel to AuthEntity
  UserEntity toEntity() => UserEntity(
        userID: userID,
        firstname: firstname,
        lastname: lastname,
        image: image,
        gender: gender,
        age: age,
        email: email,
        username: username,
        password: password,
      );

  AuthApiModel toApiModel(UserEntity entity) => AuthApiModel(
        userID: userID ?? '',
        image: entity.image,
        username: entity.username,
        email: entity.email,
        age: entity.age,
        gender: entity.gender,
        firstname: entity.firstname,
        lastname: entity.lastname,
        password: entity.password,
      );

  List<AuthApiModel> toApiModelList(List<UserEntity> entities) =>
      entities.map((entity) => toApiModel(entity)).toList();

  List<UserEntity> toEntityList(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  //ToJson
  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  //From Json
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);
  @override
  String toString() {
    return 'AuthApiModel(id: $userID, fname: $firstname, lname: $lastname, image: $image, gender: $gender, age: $age, email: $email, username: $username, password: $password)';
  }
}
