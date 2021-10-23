import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'multimedia_dto.g.dart';

enum MultimediaType {
  IMAGE,
  VIDEO,
  AUDIO,
}

@JsonSerializable()
class MultimediaDto extends Equatable {
  final String id;
  final String ownerId;
  final String filename;
  final String? contentType;
  final DateTime createdAt;
  final MultimediaType type;
  final int? size;
  final String? albumId;

  const MultimediaDto(this.id, this.ownerId, this.filename, this.contentType,
      this.createdAt, this.type, this.size, this.albumId);

  static const fromJson = _$MultimediaDtoFromJson;

  Map<String, dynamic> toJson() => _$MultimediaDtoToJson(this);

  @override
  List<Object?> get props =>
      [id, ownerId, filename, contentType, createdAt, type, size, albumId];
}
