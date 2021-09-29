// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountDto _$AccountDtoFromJson(Map<String, dynamic> json) => AccountDto(
      json['id'] as String,
      json['email'] as String,
      (json['persons'] as List<dynamic>)
          .map((e) => PersonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AccountDtoToJson(AccountDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'persons': instance.persons,
    };
