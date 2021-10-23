import 'package:amigo_flutter/src/dto/person_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'group_dto.g.dart';

@JsonSerializable()
class GroupDto extends Equatable {
  final String id;
  final String name;
  final List<PersonDto> members;

  const GroupDto(this.id, this.name, this.members);

  static const fromJson = _$GroupDtoFromJson;

  Map<String, dynamic> toJson() => _$GroupDtoToJson(this);

  @override
  List<Object?> get props => [id, name, members];
}
