// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) => PersonDto(
      json['id'] as String,
      json['name'] as String,
      json['groupId'] as String?,
      $enumDecode(_$MembershipTypeEnumMap, json['memberType']),
      json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$PersonDtoToJson(PersonDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'groupId': instance.groupId,
      'memberType': _$MembershipTypeEnumMap[instance.memberType],
      'avatarUrl': instance.avatarUrl,
    };

const _$MembershipTypeEnumMap = {
  MembershipType.OWNER: 'OWNER',
  MembershipType.ADMIN: 'ADMIN',
  MembershipType.ANALOGUE: 'ANALOGUE',
  MembershipType.MEMBER: 'MEMBER',
};
