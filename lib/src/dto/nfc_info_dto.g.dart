// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nfc_info_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NfcInfoDto _$NfcInfoDtoFromJson(Map<String, dynamic> json) => NfcInfoDto(
      json['id'] as String,
      json['creatorId'] as String,
      json['ownerId'] as String,
      $enumDecode(_$NfcInfoTypeEnumMap, json['type']),
      json['name'] as String,
      json['nfcRef'] as String,
      json['linkedPersonId'] as String?,
      json['linkedAlbumId'] as String?,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$NfcInfoDtoToJson(NfcInfoDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creatorId': instance.creatorId,
      'ownerId': instance.ownerId,
      'type': _$NfcInfoTypeEnumMap[instance.type],
      'name': instance.name,
      'nfcRef': instance.nfcRef,
      'linkedPersonId': instance.linkedPersonId,
      'linkedAlbumId': instance.linkedAlbumId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

const _$NfcInfoTypeEnumMap = {
  NfcInfoType.UNDEFINED: 'UNDEFINED',
  NfcInfoType.CALL_PERSON: 'CALL_PERSON',
  NfcInfoType.OPEN_ALBUM: 'OPEN_ALBUM',
  NfcInfoType.SYSTEM: 'SYSTEM',
  NfcInfoType.LOGIN: 'LOGIN',
};
