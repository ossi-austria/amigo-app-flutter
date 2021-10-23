// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GroupDto _$GroupDtoFromJson(Map<String, dynamic> json) => GroupDto(
      json['id'] as String,
      json['name'] as String,
      (json['members'] as List<dynamic>)
          .map((e) => PersonDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GroupDtoToJson(GroupDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members,
    };
