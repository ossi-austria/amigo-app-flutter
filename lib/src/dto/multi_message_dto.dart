import 'package:amigoapp/src/dto/multimedia_dto.dart';
import 'package:amigoapp/src/dto/sendable_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multi_message_dto.g.dart';

@JsonSerializable()
class MultiMessageDto extends SendableDto with EquatableMixin {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final MultimediaDto? multimedia;
  final String? multimediaId;
  final DateTime createdAt;
  final DateTime? sentAt;
  final DateTime? retrievedAt;

  const MultiMessageDto(
      this.id,
      this.senderId,
      this.receiverId,
      this.text,
      this.multimedia,
      this.multimediaId,
      this.createdAt,
      this.sentAt,
      this.retrievedAt)
      : super(id, senderId, receiverId, createdAt, sentAt, retrievedAt);

  static const fromJson = _$MultiMessageDtoFromJson;

  Map<String, dynamic> toJson() => _$MultiMessageDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        text,
        multimedia,
        multimediaId,
        createdAt,
        sentAt,
        retrievedAt
      ];
}
