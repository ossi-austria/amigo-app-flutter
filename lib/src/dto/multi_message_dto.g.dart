// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'multi_message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiMessageDto _$MultiMessageDtoFromJson(Map<String, dynamic> json) =>
    MultiMessageDto(
      json['id'] as String,
      json['senderId'] as String,
      json['receiverId'] as String,
      json['text'] as String,
      json['multimedia'] == null
          ? null
          : MultimediaDto.fromJson(json['multimedia'] as Map<String, dynamic>),
      json['multimediaId'] as String?,
      DateTime.parse(json['createdAt'] as String),
      json['sentAt'] == null ? null : DateTime.parse(json['sentAt'] as String),
      json['retrievedAt'] == null
          ? null
          : DateTime.parse(json['retrievedAt'] as String),
    );

Map<String, dynamic> _$MultiMessageDtoToJson(MultiMessageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'text': instance.text,
      'multimedia': instance.multimedia,
      'multimediaId': instance.multimediaId,
      'createdAt': instance.createdAt.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
      'retrievedAt': instance.retrievedAt?.toIso8601String(),
    };
