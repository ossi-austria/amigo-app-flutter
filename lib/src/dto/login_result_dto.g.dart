// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResultDto _$LoginResultDtoFromJson(Map<String, dynamic> json) =>
    LoginResultDto(
      SecretAccountDto.fromJson(json['account'] as Map<String, dynamic>),
      TokenResultDto.fromJson(json['refreshToken'] as Map<String, dynamic>),
      TokenResultDto.fromJson(json['accessToken'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResultDtoToJson(LoginResultDto instance) =>
    <String, dynamic>{
      'account': instance.account,
      'refreshToken': instance.refreshToken,
      'accessToken': instance.accessToken,
    };
