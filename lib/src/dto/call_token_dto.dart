import 'package:amigoapp/src/dto/sendable_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'call_token_dto.g.dart';

enum CallType {
  VIDEO,
  AUDIO,
}

extension CallTypeExtension on CallType {
  String get stringValue => describeEnum(this);
}

enum CallState {
  CREATED, // Call was created technical, no Notification sent yet
  CALLING, // Notification sent, should display Calling window
  CANCELLED, // caller cancels
  DENIED, // callee denies/cancels
  ACCEPTED, // callee accepted

  //    STARTED, // both parties entered the room
  FINISHED, // success to finish
  TIMEOUT, // timeout or technical timeout
}

@JsonSerializable()
class CallTokenDto extends SendableDto with EquatableMixin {
  final String id;
  final String senderId;
  final String receiverId;
  final CallType callType;
  final DateTime? startedAt;
  final DateTime? finishedAt;
  final CallState callState;
  final String? token;
  final DateTime createdAt;
  final DateTime? sentAt;
  final DateTime? retrievedAt;

  const CallTokenDto(
      this.id,
      this.senderId,
      this.receiverId,
      this.callType,
      this.startedAt,
      this.finishedAt,
      this.callState,
      this.token,
      this.createdAt,
      this.sentAt,
      this.retrievedAt)
      : super(id, senderId, receiverId, createdAt, sentAt, retrievedAt);

  static const fromJson = _$CallTokenDtoFromJson;

  Map<String, dynamic> toJson() => _$CallTokenDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        callType,
        startedAt,
        finishedAt,
        callState,
        token,
        createdAt,
        sentAt,
        retrievedAt
      ];
}
