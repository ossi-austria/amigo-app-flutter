import 'package:amigoapp/src/dto/sendable_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_token_dto.g.dart';

@JsonSerializable()
class MessageTokenDto extends SendableDto with EquatableMixin {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final String? multimediaId;
  final DateTime createdAt;
  final DateTime? sentAt;
  final DateTime? retrievedAt;

  const MessageTokenDto(this.id, this.senderId, this.receiverId, this.text,
      this.multimediaId, this.createdAt, this.sentAt, this.retrievedAt)
      : super(id, senderId, receiverId, createdAt, sentAt, retrievedAt);

  static const fromJson = _$MessageTokenDtoFromJson;

  Map<String, dynamic> toJson() => _$MessageTokenDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        text,
        multimediaId,
        createdAt,
        sentAt,
        retrievedAt
      ];
}
