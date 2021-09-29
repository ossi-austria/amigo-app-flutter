// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TokenResultDto _$TokenResultDtoFromJson(Map<String, dynamic> json) =>
    TokenResultDto(
      json['token'] as String,
      json['subject'] as String,
      DateTime.parse(json['issuedAt'] as String),
      DateTime.parse(json['expiration'] as String),
      json['issuer'] as String,
    );

Map<String, dynamic> _$TokenResultDtoToJson(TokenResultDto instance) =>
    <String, dynamic>{
      'token': instance.token,
      'subject': instance.subject,
      'issuedAt': instance.issuedAt.toIso8601String(),
      'expiration': instance.expiration.toIso8601String(),
      'issuer': instance.issuer,
    };
