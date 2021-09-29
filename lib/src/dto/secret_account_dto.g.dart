// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_account_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecretAccountDto _$SecretAccountDtoFromJson(Map<String, dynamic> json) =>
    SecretAccountDto(
      json['id'] as String,
      json['email'] as String,
      json['changeAccountToken'] as String?,
      json['changeAccountTokenCreatedAt'] == null
          ? null
          : DateTime.parse(json['changeAccountTokenCreatedAt'] as String),
      (json['persons'] as List<dynamic>)
          .map((e) => PersonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SecretAccountDtoToJson(SecretAccountDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'changeAccountToken': instance.changeAccountToken,
      'changeAccountTokenCreatedAt':
          instance.changeAccountTokenCreatedAt?.toIso8601String(),
      'persons': instance.persons,
    };
