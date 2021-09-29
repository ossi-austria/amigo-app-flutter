// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_exception_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RestExceptionDto _$RestExceptionDtoFromJson(Map<String, dynamic> json) =>
    RestExceptionDto(
      json['errorCode'] as int,
      json['errorName'] as String,
      json['errorMessage'] as String,
      DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$RestExceptionDtoToJson(RestExceptionDto instance) =>
    <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorName': instance.errorName,
      'errorMessage': instance.errorMessage,
      'time': instance.time.toIso8601String(),
    };
