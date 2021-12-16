// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_token_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CallTokenDto _$CallTokenDtoFromJson(Map<String, dynamic> json) => CallTokenDto(
      json['id'] as String,
      json['senderId'] as String,
      json['receiverId'] as String,
      $enumDecode(_$CallTypeEnumMap, json['callType']),
      json['startedAt'] == null
          ? null
          : DateTime.parse(json['startedAt'] as String),
      json['finishedAt'] == null
          ? null
          : DateTime.parse(json['finishedAt'] as String),
      $enumDecode(_$CallStateEnumMap, json['callState']),
      json['token'] as String?,
      DateTime.parse(json['createdAt'] as String),
      json['sentAt'] == null ? null : DateTime.parse(json['sentAt'] as String),
      json['retrievedAt'] == null
          ? null
          : DateTime.parse(json['retrievedAt'] as String),
    );

Map<String, dynamic> _$CallTokenDtoToJson(CallTokenDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'callType': _$CallTypeEnumMap[instance.callType],
      'startedAt': instance.startedAt?.toIso8601String(),
      'finishedAt': instance.finishedAt?.toIso8601String(),
      'callState': _$CallStateEnumMap[instance.callState],
      'token': instance.token,
      'createdAt': instance.createdAt.toIso8601String(),
      'sentAt': instance.sentAt?.toIso8601String(),
      'retrievedAt': instance.retrievedAt?.toIso8601String(),
    };

const _$CallTypeEnumMap = {
  CallType.VIDEO: 'VIDEO',
  CallType.AUDIO: 'AUDIO',
};

const _$CallStateEnumMap = {
  CallState.CREATED: 'CREATED',
  CallState.CALLING: 'CALLING',
  CallState.CANCELLED: 'CANCELLED',
  CallState.DENIED: 'DENIED',
  CallState.ACCEPTED: 'ACCEPTED',
  CallState.FINISHED: 'FINISHED',
  CallState.TIMEOUT: 'TIMEOUT',
};
