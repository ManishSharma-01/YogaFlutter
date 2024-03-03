// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllAuthDTO _$GetAllAuthDTOFromJson(Map<String, dynamic> json) =>
    GetAllAuthDTO(
      success: json['success'] as bool,
      count: json['count'] as int,
      data: (json['data'] as List<dynamic>)
          .map((e) => AuthApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetAllAuthDTOToJson(GetAllAuthDTO instance) =>
    <String, dynamic>{
      'success': instance.success,
      'count': instance.count,
      'data': instance.data,
    };
