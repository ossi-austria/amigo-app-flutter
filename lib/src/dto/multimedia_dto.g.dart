// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multimedia_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultimediaDto _$MultimediaDtoFromJson(Map<String, dynamic> json) =>
    MultimediaDto(
      json['id'] as String,
      json['ownerId'] as String,
      json['filename'] as String,
      json['contentType'] as String?,
      DateTime.parse(json['createdAt'] as String),
      $enumDecode(_$MultimediaTypeEnumMap, json['type']),
      json['size'] as int?,
      json['albumId'] as String?,
    );

Map<String, dynamic> _$MultimediaDtoToJson(MultimediaDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ownerId': instance.ownerId,
      'filename': instance.filename,
      'contentType': instance.contentType,
      'createdAt': instance.createdAt.toIso8601String(),
      'type': _$MultimediaTypeEnumMap[instance.type],
      'size': instance.size,
      'albumId': instance.albumId,
    };

const _$MultimediaTypeEnumMap = {
  MultimediaType.IMAGE: 'IMAGE',
  MultimediaType.VIDEO: 'VIDEO',
  MultimediaType.AUDIO: 'AUDIO',
};
