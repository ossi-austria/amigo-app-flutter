import 'package:amigoapp/src/dto/multimedia_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'album_dto.g.dart';

@JsonSerializable()
class AlbumDto extends Equatable {
  final String id;
  final String name;
  final String ownerId;
  final List<MultimediaDto> items;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AlbumDto(this.id, this.name, this.ownerId, this.items, this.createdAt,
      this.updatedAt);

  static const fromJson = _$AlbumDtoFromJson;

  Map<String, dynamic> toJson() => _$AlbumDtoToJson(this);

  @override
  List<Object?> get props => [id, name, ownerId, items, createdAt, updatedAt];
}
