// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      userID: json['_id'] as String?,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      image: json['image'] as String?,
      age: json['age'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.userID,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'image': instance.image,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'username': instance.username,
      'password': instance.password,
    };
