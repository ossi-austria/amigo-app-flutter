// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDto _$PersonDtoFromJson(Map<String, dynamic> json) => PersonDto(
      json['id'] as String,
      json['name'] as String,
      json['groupId'] as String?,
      _$enumDecode(_$MembershipTypeEnumMap, json['memberType']),
      json['avatarUrl'] as String?,
    );

Map<String, dynamic> _$PersonDtoToJson(PersonDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'groupId': instance.groupId,
      'memberType': _$MembershipTypeEnumMap[instance.memberType],
      'avatarUrl': instance.avatarUrl,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

const _$MembershipTypeEnumMap = {
  MembershipType.OWNER: 'OWNER',
  MembershipType.ADMIN: 'ADMIN',
  MembershipType.ANALOGUE: 'ANALOGUE',
  MembershipType.MEMBER: 'MEMBER',
};
