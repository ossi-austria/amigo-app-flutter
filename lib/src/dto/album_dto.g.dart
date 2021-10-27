// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDto _$AlbumDtoFromJson(Map<String, dynamic> json) => AlbumDto(
      json['id'] as String,
      json['name'] as String,
      json['ownerId'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => MultimediaDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$AlbumDtoToJson(AlbumDto instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'ownerId': instance.ownerId,
      'items': instance.items,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
