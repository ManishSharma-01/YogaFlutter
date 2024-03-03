import 'package:fitbit/features/auth/data/model/auth_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_auth_dto.g.dart';

@JsonSerializable()
class GetAllAuthDTO {
  final bool success;
  final int count;
  final List<AuthApiModel> data;

  GetAllAuthDTO({
    required this.success,
    required this.count,
    required this.data,
  });

  Map<String, dynamic> toJson() => _$GetAllAuthDTOToJson(this);
  factory GetAllAuthDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllAuthDTOFromJson(json);
}
