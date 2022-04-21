// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageTokenDto _$MessageTokenDtoFromJson(Map<String, dynamic> json) =>
    MessageTokenDto(
      json['id'] as String,
      json['senderId'] as String,
      json['receiverId'] as String,
      json['text'] as String,
      json['multimediaId'] as String?,
      DateTime.parse(json['createdAt'] as String),
      json['sentAt'] == null ? null : DateTime.parse(json['sentAt'] as String),
      json['retrievedAt'] == null
          ? null
          : DateTime.parse(json['retrievedAt'] as String),
    );

Map<String, dynamic> _$MessageTokenDtoToJson(MessageTokenDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'text': instance.text,
      'multimediaId': instance.multimediaId,
      'createdAt': instance.createdAt.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
      'retrievedAt': instance.retrievedAt?.toIso8601String(),
    };
