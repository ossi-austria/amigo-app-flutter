import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nfc_info_dto.g.dart';

enum NfcInfoType {
  UNDEFINED,
  CALL_PERSON,
  OPEN_ALBUM,
  SYSTEM,
  LOGIN,
}

@JsonSerializable()
class NfcInfoDto extends Equatable {
  final String id;
  final String creatorId;
  final String ownerId;
  final NfcInfoType type;
  final String name;
  final String nfcRef;
  final String? linkedPersonId;
  final String? linkedAlbumId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const NfcInfoDto(
      this.id,
      this.creatorId,
      this.ownerId,
      this.type,
      this.name,
      this.nfcRef,
      this.linkedPersonId,
      this.linkedAlbumId,
      this.createdAt,
      this.updatedAt);

  static const fromJson = _$NfcInfoDtoFromJson;

  Map<String, dynamic> toJson() => _$NfcInfoDtoToJson(this);

  @override
  List<Object?> get props => [
        id,
        creatorId,
        ownerId,
        type,
        name,
        nfcRef,
        linkedPersonId,
        linkedAlbumId,
        createdAt,
        updatedAt,
      ];
}
