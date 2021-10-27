import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'person_dto.g.dart';

enum MembershipType { OWNER, ADMIN, ANALOGUE, MEMBER }

@JsonSerializable()
class PersonDto extends Equatable {
  final String id;
  final String name;
  final String? groupId;
  final MembershipType memberType;
  final String? avatarUrl;

  const PersonDto(
      this.id, this.name, this.groupId, this.memberType, this.avatarUrl);

  static const fromJson = _$PersonDtoFromJson;

  Map<String, dynamic> toJson() => _$PersonDtoToJson(this);

  @override
  List<Object?> get props => [id, name, groupId, memberType, avatarUrl];
}
